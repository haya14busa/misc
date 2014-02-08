#!/usr/bin/env python
# -*- coding: utf-8 -*-
# FILE: /home/haya14busa/.vim_junk/2014/01/2014-01-19-002222.py
# AUTHOR: haya14busa
# License: MIT license
#
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
#
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
#
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
#=============================================================================
import yaml

# Scraping
import urllib2
from bs4 import BeautifulSoup


LINGR_YML_URL = \
    'http://lingr-bot-readingvimrc.herokuapp.com/reading_vimrc/vimplugin/yml'

ARCHIVE_URL = 'http://vim-jp.org/reading-vimrc/archive/{id}.html'

# _data/jikaiyokoku.yml
# id: 83
# date: 2013-12-14 21:00
# author: 5t111111
# link: https://github.com/5t111111/dotfiles/blob/master/.vimrc


def html2yaml(url):
    html = urllib2.urlopen(url).read()
    return yaml.load(html)


def yaml2file(ymldict, filename):
    f = open(filename + '.yml', 'w')
    try:
        f.write(yaml.safe_dump(ymldict, default_flow_style=False))
    finally:
        f.close()


class VimrcData(object):
    def __init__(self, id):
        self.id = id
        self.url = 'http://vim-jp.org/reading-vimrc/archive/{id}.html'.format(
            id=str(id).rjust(3, '0'))
        self.soup = self.getSoup()

        header = self.soup.find('section').findAll('h3')

        self.date = header[0].findNext().text
        if self.id < 6:
            self.vimrc_url = header[1].findNext('a').get('href')
        else:
            self.vimrc_url = header[1].findNext('a').findNext('a').get('href')

        self.raw_url = self.getRawURL(self.vimrc_url)
        self.members = map(
            lambda x: x.text,
            header[2].findNext('ul').findChildren())
        self.log_url = header[3].findNext('a').get('href')
        try:
            self.links = map(
                lambda x: x.get('href'),
                header[4].findNext('ul').findChildren('a'))
        except IndexError:
            self.links = []

        self.author = self.getAuthor(self.vimrc_url)
        self.hash = self.getHash(self.vimrc_url)

    def getAuthor(self, github_url):
        # https://github.com/{author}/dotfiles/blob/{hash}/.vimrc
        return github_url.rsplit('/')[3]

    def getHash(self, github_url):
        return github_url.rsplit('/')[6]

    def getRawURL(self, github_url):
        # https://raw.github.com/{author}/dotfiles/{hash}/.vimrc
        return github_url.replace('github.com', 'raw.github.com') \
                         .replace('blob/', '')

    def getDict(self):
        data = {
            'id': self.id,
            'date': self.date,
            'url': self.vimrc_url,
            'raw_url': self.raw_url,
            'author': self.author,
            'hash': self.hash,
            'members': self.members,
            'log': self.log_url,
            'links': self.links,
        }
        return data

    def getSoup(self):
        html = urllib2.urlopen(self.url).read()
        return BeautifulSoup(html)

    def pringAllData(self):
        print(self.id)
        print(self.date)
        print(self.vimrc_url)
        print(self.members)
        print(self.log_url)
        print(self.links)


def main():
    archives = []
    for i in xrange(81):
        try:
            vimrc = VimrcData(i+1)
            data = vimrc.getDict()
            archives.append(data)
        except:
            print('Error: ' + str(i))
    yaml2file(archives, 'archives')

if __name__ == '__main__':
    main()
