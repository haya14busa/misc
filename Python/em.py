#!/usr/bin/env python

text = '''
lorem ipsum dolor sit amet, consectetur adipiscing elit. suspendisse
sagittis sollicitudin cursus. proin quis nisl tempus, facilisis nisl
volutpat, consectetur ipsum. sed congue, mauris a vestibulum
condimentum, elit nulla lacinia arcu, id eleifend metus magna in lacus.

nam vel nisi a a a a a a a b b b b b ab ab ab ab ab consectetur,
aliquam ligula egestas, interdum mauris.  maecenas in mauris quis velit
fermentum iaculis id in nunc. in molestie odio faucibus consectetur

consectetur. sed w w w wawa awawa awaw awaww qvarius, eros a dictum
ornare, nibh eros blandit enim, ut sollicitudin justo mauris ac elit.
'''

import re

group_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
group_chars_len = len(group_chars)

new_text = text[:]

motions = {
	'w': {
		'match_target': re.compile(r'\b\w', re.UNICODE | re.LOCALE),
		'match_char_space': re.compile(r'(\w*)', re.UNICODE | re.LOCALE),
		}
	}


def mktree(targets):
	# Split list into even chunks
	target_chunks = [targets[i:i + group_chars_len] for i in range(0, len(targets), group_chars_len)]
	if len(target_chunks) > group_chars_len:
		target_chunks = mktree(target_chunks)
	return target_chunks


def node_from_path(tree, path=None):
	if path is None or not len(path):
		return tree
	current = tree
	for i in path:
		current = current[i]
	return current


def replace_text(text, targets, path=None):
	if path is None:
		path = []
	current_targets = node_from_path(targets, path)
	for i, target in enumerate(current_targets):
		if not 'match' in target:
			text = replace_text(text, targets, path + [i])
		else:
			jump_str = ''.join([group_chars[n] for n in path + [i]])[0:target['char_space']]
			start = target['span'][0]
			end = start + len(jump_str)
			text = text[:start] + jump_str + text[end:]
	return text


for motion in motions.keys():
	targets = [{
		'span': m.span(),
		'match': m.group(),
		'char_space': re.match(motions[motion]['match_char_space'], text[m.start():]).span()[1],
		} for m in re.finditer(motions[motion]['match_target'], text)]
	tree = mktree(targets)
	new_text = replace_text(new_text, tree)
	print(text)
	print('------------')
	print(new_text)