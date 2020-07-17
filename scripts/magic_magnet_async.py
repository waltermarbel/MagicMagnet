import os
import json
import urllib.parse
from pathlib import Path
from bs4 import BeautifulSoup, SoupStrainer
import asyncio
import aiohttp


class MagicMagnet():
    def __init__(self):
        self.links = {'foundLinks': 0}
    
    async def search(self, searchContent, google = True, tpb = False, l337x = False, nyaa = False, eztv = False, yts = False, demonoid = False, ettv = False):
        searchContent = urllib.parse.quote_plus(f'{searchContent}')

        if google:
            params = {
                'searchURL': f'https://www.google.com/search?q={searchContent}+download+torrent',
                'start': '/url?q=',
                'notIn': ['accounts.google.com', '.org', 'youtube.com', 'facebook.com'],
                'sliceString': [7, -88]
                }

            await self._getDownloadPages(params['searchURL'], start = params['start'], notIn = params['notIn'], sliceString = params['sliceString'])

        if tpb:
            for i in range(5):
                await self._getPageLinks(f'https://tpb.party/search/{searchContent}/{i + 1}/7/0')

        if l337x:
            params = {
                'searchURL': f'https://www.1377x.to/search/{searchContent}/1/',
                'start': '/torrent',
                'resultURL': 'https://www.1377x.to'
                }
            
            await self._getDownloadPages(params['searchURL'], resultURL = params['resultURL'], start = params['start'])

        if nyaa:
            for i in range(5):
                await self._getPageLinks(f'https://nyaa.si/?q={searchContent}&f=0&c=0_0&s=seeders&o=desc&p={i + 1}')
        
        if eztv:
            await self._getPageLinks(f'https://eztv.io/search/{searchContent}')

        if yts:
            params = {
                'searchURL': f'https://yts.mx/browse-movies/{searchContent}/all/all/0/latest',
                'start': 'https://yts.mx/movie/'
                }
                
            await self._getDownloadPages(params['searchURL'], start = params['start'])
        
        if demonoid:
            params = {
                'searchURL': f'https://demonoid.is/files/?category=0&subcategory=0&quality=0&seeded=2&external=2&query={searchContent}&sort=',
                'start': '/files/details',
                'resultURL': 'https://demonoid.is'
                }

            await self._getDownloadPages(params['searchURL'], start = params['start'], resultURL = params['resultURL'])
        
        if ettv:
            params = {
            'searchURL': f'https://www.ettv.to/torrents-search.php?search={searchContent}',
            'start': '/torrent/',
            'resultURL': 'https://www.ettv.to'
            }

            await self._getDownloadPages(params['searchURL'], start = params['start'], resultURL = params['resultURL'])

    async def _getDownloadPages(self, searchURL, resultURL = None, start = None, notIn = None, sliceString = None):
        async with aiohttp.ClientSession() as client:
        
	        async with client.get(searchURL) as request:
		        result = BeautifulSoup(await request.text(), 'lxml', parse_only = SoupStrainer('a'))
		
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
		                            await self._getPageLinks(f'{resultURL}{i.get("href")[sliceString[0]:sliceString[1]]}')
		                        else:
		                            await self._getPageLinks(f'{resultURL}{i.get("href")}')
		                    else:
		                        if sliceString != None:
		                            await self._getPageLinks(i.get('href')[sliceString[0]:sliceString[1]])
		                        else:
		                            await self._getPageLinks(i.get('href'))

    async def _getPageLinks(self, searchURL):
        if searchURL.endswith('/&s'):
            searchURL = searchURL[:-2] 

        #sg.Print(f'Searching in: {searchURL}\n', font=('Segoe UI', 10), no_button=True)
        print(f'Searching in: {searchURL}\n')
        
        async with aiohttp.ClientSession() as client:
        	async with client.get(searchURL) as request:
	      
		        result = BeautifulSoup(await request.text(), 'lxml', parse_only = SoupStrainer('a'))
		
		        for i in result.find_all('a', href = True):
		            if (i.get('href') != None) and (i.get('href').startswith('magnet:?xt=')) and (len(i.get('href')) > 64):
		                if i.get('href') not in self.links:
		                    self.links[self._getTorrentName(i.get('href'))] = i.get('href')
		        
		        self.links['foundLinks'] = len(self.links)

    def _getTorrentName(self, magnetLink):
        name = magnetLink.split('tr=')[0][64:-1]

        if name.startswith(';dn=') and name.endswith('&amp'):
            name = name[4:-4]

        return urllib.parse.unquote_plus(name)

    async def magnetsToJSON(self, filename):
        if os.path.exists(os.path.join(os.getcwd(), 'json')) == False:
            os.mkdir(os.path.join(os.getcwd(), 'json'))

        pathToFile = os.path.join(os.getcwd(), 'json')

        data = json.dumps(self.links, indent = 4)

        with open(os.path.join(pathToFile, f'{filename}.json'), 'w', encoding = 'utf-8') as file:
            file.write(data)

async def main():  
	magic_magnet = MagicMagnet()
	await magic_magnet.search('Ubuntu', google = False, tpb = True)
	print(magic_magnet.links)
	
loop = asyncio.get_event_loop()
loop.run_until_complete(main())
loop.close()
