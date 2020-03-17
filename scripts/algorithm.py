import requests
import re
import os
import json
import PySimpleGUI as sg
import urllib.parse
from pathlib import Path
from bs4 import BeautifulSoup, SoupStrainer


class GetMagnet():
    # We store our links in this variable, and count every found one
    
    def __init__(self):
        self.links = {'foundLinks': 0}

    # In this method, we catch the search content, and check in every provider
    # selected (which means True to the value)
    # 
    # Example:
    # process.search('Ubuntu 19.04', google = False, tpb = True)
    # 
    # It will search for Ubuntu 19.04 only in The Pirate Bay
    
    def search(self, searchContent, google = True, tpb = False, l337x = False, nyaa = False, eztv = False, yts = False, demonoid = False, ettv = False):
        # We are converting the string that user inserted into a
        # proper URL string, to avoid errors
        
        searchContent = urllib.parse.quote_plus(f'{searchContent}')

        # Params are certain options that _getDownloadPages() method can use
        # in order to perform a search. I'm using it with a dictionary, but
        # you can also use as you want.
        # 
        # Requerid parameters:
        # - searchURL:
        #   A variable that hold a string with the terms the user type.
        # 
        # Optional parameters:
        # - resultURL:
        #   A variable that hold a string with the domain of a website.
        #   Usually, found links are in '/link/123456' format, which means
        #   that website treat them as a route. So, in order to acess that,
        #   we have to add the domain in the start of link.
        # 
        #   Example:
        #   In ETTV, the first result for 'Mr. Robot' was '/torrent/781815/mr-robot-4x01-13-web-dlmux-xvid-ita-eng-ac3-earine'
        #   Then, the resultURL should be 'https://www.ettv.to'.
        # 
        # - start:
        #   A variable that hold a string with a certain pattern to the begin of link,
        #   to differentiate from those that don't are right.
        # 
        #   Example:
        #   All Google links starts with '/url?q=' in the URL
        if google:
            params = {
                'searchURL': f'https://www.google.com/search?q={searchContent}+download+torrent',
                'start': '/url?q=',
                'notIn': ['accounts.google.com', '.org', 'youtube.com', 'facebook.com'],
                'sliceString': [7, -88]
                }

            self._getDownloadPages(params['searchURL'], start = params['start'], notIn = params['notIn'], sliceString = params['sliceString'])

        if tpb:
            for i in range(5):
                self._getPageLinks(f'https://tpb.party/search/{searchContent}/{i + 1}/7/0')

        if l337x:
            params = {
                'searchURL': f'https://www.1377x.to/search/{searchContent}/1/',
                'start': '/torrent',
                'resultURL': 'https://www.1377x.to'
                }
            
            self._getDownloadPages(params['searchURL'], resultURL = params['resultURL'], start = params['start'])

        if nyaa:
            for i in range(5):
                self._getPageLinks(f'https://nyaa.si/?q={searchContent}&f=0&c=0_0&s=seeders&o=desc&p={i + 1}')
        
        if eztv:
            self._getPageLinks(f'https://eztv.io/search/{searchContent}')

        if yts:
            params = {
                'searchURL': f'https://yts.mx/browse-movies/{searchContent}/all/all/0/latest',
                'start': 'https://yts.mx/movie/'
                }
                
            self._getDownloadPages(params['searchURL'], start = params['start'])
        
        if demonoid:
            params = {
                'searchURL': f'https://demonoid.is/files/?category=0&subcategory=0&quality=0&seeded=2&external=2&query={searchContent}&sort=',
                'start': '/files/details',
                'resultURL': 'https://demonoid.is'
                }

            self._getDownloadPages(params['searchURL'], start = params['start'], resultURL = params['resultURL'])
        
        if ettv:
            params = {
            'searchURL': f'https://www.ettv.to/torrents-search.php?search={searchContent}',
            'start': '/torrent/',
            'resultURL': 'https://www.ettv.to'
            }

            self._getDownloadPages(params['searchURL'], start = params['start'], resultURL = params['resultURL'])

    def _getDownloadPages(self, searchURL, resultURL = None, start = None, notIn = None, sliceString = None):
        request = requests.get(searchURL)
        result = BeautifulSoup(request.content, 'lxml', parse_only = SoupStrainer('a'))

        linksChecked = []

        for i in result.find_all('a', href = True):
            if i.get('href').startswith(start) and i.get('href') not in linksChecked and ('#download' not in i.get('href')):
                
                valid = True

                if (start != None) and (notIn != None):
                    for link in notIn:
                        if link in i.get('href'):
                            valid = False

                if valid == True:
                    linksChecked.append(i.get('href'))
                    if resultURL != None:
                        if sliceString != None:
                            self._getPageLinks(f'{resultURL}{i.get("href")[sliceString[0]:sliceString[1]]}')
                        else:
                            self._getPageLinks(f'{resultURL}{i.get("href")}')
                    else:
                        if sliceString != None:
                            self._getPageLinks(i.get('href')[sliceString[0]:sliceString[1]])
                        else:
                            self._getPageLinks(i.get('href'))

    def _getPageLinks(self, searchURL):
        if searchURL.endswith('/&s'):
            searchURL = searchURL[:-2] 

        sg.Print(f'Searching in: {searchURL}\n', font=('Segoe UI', 10), no_button=True)
        # print(f'Searching in: {searchURL}\n')

        try:
            request = requests.get(searchURL)
        except:
            print('Something went wrong.')
            return 0
        
        result = BeautifulSoup(request.content, 'lxml', parse_only = SoupStrainer('a'))

        for i in result.find_all('a', href = True):
            if (i.get('href') != None) and (i.get('href').startswith('magnet:?xt=')) and (len(i.get('href')) > 64):
                if i.get('href') not in self.links:
                    self.links[self._getTorrentName(i.get('href'))] = i.get('href')
                    self.links['foundLinks'] += 1

    def _getTorrentName(self, magnetLink):
        name = magnetLink.split('tr=')[0][64:-1]

        if name.startswith(';dn=') and name.endswith('&amp'):
            name = name[4:-4]

        return urllib.parse.unquote_plus(name)


    # Deprecated method, use magnetsToJSON instead

    def magnetsToPlainText(self, filename):
        if os.path.exists(os.path.join(Path.home(), 'Downloads', 'MagicMagnet')) == False:
            os.mkdir(os.path.join(Path.home(), 'Downloads', 'MagicMagnet'))

        pathToFile = os.path.join(Path.home(), 'Downloads', 'MagicMagnet')

        with open(os.path.join(pathToFile, f'{filename}.txt'), 'w', encoding = 'utf-8') as file:
            for name, magnetLink in self.links.items():
                file.write(f'{name}\n{magnetLink}\n\n')

        return pathToFile

    def magnetsToJSON(self, filename):
        if os.path.exists(os.path.join(Path.home(), 'Downloads', 'MagicMagnet')) == False:
            os.mkdir(os.path.join(Path.home(), 'Downloads', 'MagicMagnet'))

        pathToFile = os.path.join(Path.home(), 'Downloads', 'MagicMagnet')
        data = json.dumps(self.links, indent = 4)

        with open(os.path.join(pathToFile, f'{filename}.json'), 'w', encoding = 'utf-8') as file:
            file.write(data)

        return pathToFile