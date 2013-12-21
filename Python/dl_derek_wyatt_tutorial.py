#!/usr/bin/env python
# -*- coding:utf-8 -*-
#
# Download Screencast from Derek Vim tutorial

# Scraping
import urllib2
from bs4 import BeautifulSoup

# youtube-dl
try:
    import youtube_dl
except:
    print 'pip install youtube-dl'
    sys.exit()

# sys
import sys

def getBaseURL():
    # URL = 'http://www.derekwyatt.org/vim/vim-tutorial-videos/vim-novice-tutorial-videos/'
    # Sample vimeo -> http://vimeo.com/6999927
    if len(sys.argv) != 2:
        print 'Invalid parameter'
    else:
       return sys.argv[1]

def getSoup(url):
    html = urllib2.urlopen(url).read()
    return BeautifulSoup(html)

def getVimeoId(soup):
    parameter = 'clip_id='
    vimeoIDs = []
    for tag in soup.findAll('param',{'name':'movie'}):
        ''' http://vimeo.com/moogaloop.swf?clip_id=7035132&server=vimeo.com&show_title=1&show_byline=0&show_portrait=0&color=00ADEF&fullscreen=1'''

        ''' http://vimeo.com/7035132'''
        fullurl = tag.get('value') # -> Vimeo URL(parameter)
        value = parseParam(fullurl,parameter)
        vimeoIDs.append(value)
    return vimeoIDs

def parseParam(url,param):
    start = url.find(param) + len(param)
    end = url[start:].find('&')
    return url[start:start+end]

def main():
    print '\("`v")/ Start!'
    URL = getBaseURL()
    soup = getSoup(URL)
    vimeoIDs = getVimeoId(soup)

    VIMEO = 'http://vimeo.com/'
    urls = map(lambda x: VIMEO+x,vimeoIDs)

    ytdl_param = ['-t', '-A']
    youtube_dl.main(ytdl_param+urls)
    print '\("`v")/ END!'

if __name__ == '__main__':
    main()
