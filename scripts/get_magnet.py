import requests
import os
import PySimpleGUI as sg
import urllib.parse
from pathlib import Path
from bs4 import BeautifulSoup, SoupStrainer


class GetMagnet():
    def __init__(self):
        self.links = {}
        self.download_pages_torrentz2 = []

    def get_magnet(self, search_content, google = True, tpb = False, l337x = False, nyaa = False, eztv = False, yts = False, demonoid = False, ettv = False, torrentz2 = False):
        search_content = urllib.parse.quote_plus(f"{search_content}")

        if google:
            search_url = f"https://www.google.com/search?q={search_content}+download+torrent"
            start = "/url?q="
            not_in = ["accounts.google.com", ".org", "youtube.com", "facebook.com"]
            pages = self.get_download_pages(search_url = search_url, start = start, not_in = not_in, slice = [7, -88])
            link = self.get_download_links(pages)
            self.links.update(link)

        if tpb:
            pages = []

            [pages.append(f"https://tpb.party/search/{search_content}/{i + 1}/7/0") for i in range(5)]

            link = self.get_download_links(pages)
            self.links.update(link)

        if l337x:
            search_url = f"https://www.1377x.to/search/{search_content}/1/"
            start = "/torrent"
            result_url = "https://www.1377x.to"
            pages = self.get_download_pages(search_url = search_url, result_url = result_url, start = start)
            link = self.get_download_links(pages)
            self.links.update(link)

        if nyaa:
            pages = []

            [pages.append(f"https://nyaa.si/?q={search_content}&f=0&c=0_0&s=seeders&o=desc&p={i + 1}") for i in range(5)]

            link = self.get_download_links(pages)
            self.links.update(link)

        if eztv:
            pages = f"https://eztv.io/search/{search_content}"

            link = self.get_download_links(list(pages))
            self.links.update(link)

        if yts:
            search_url = f"https://yts.mx/browse-movies/{search_content}/all/all/0/latest"
            start = "https://yts.mx/movie/"
            pages = self.get_download_pages(search_url = search_url, start = start)
            link = self.get_download_links(pages)
            self.links.update(link)

        if demonoid:
            search_url = f"https://demonoid.is/files/?category=0&subcategory=0&quality=0&seeded=2&external=2&query={search_content}&sort="
            start = "/files/details"
            result_url = "https://demonoid.is"
            pages = self.get_download_pages(search_url = search_url, start = start, result_url = result_url)
            link = self.get_download_links(pages[:20])
            self.links.update(link)

        if ettv:
            search_url = f"https://www.ettv.to/torrents-search.php?search={search_content}"
            start = "/torrent/"
            result_url = "https://www.ettv.to"
            pages = self.get_download_pages(search_url = search_url, start = start, result_url = result_url)
            link = self.get_download_links(pages)
            self.links.update(link)

        if torrentz2:
            search_url = f"https://torrentz2.eu/search?f={search_content}"
            start = "/"
            not_in = ["/lorem2", "/search", "/help", "/my", "/verified", "/feed"]
            result_url = "https://torrentz2.eu"
            download_pages_torrentz2 = self.get_download_pages(search_url = search_url, start = start, result_url = result_url, not_in = not_in)

            sg.Print("Searching for the pages. This may take a while.\n\n")
            
            for i in range(1, 5):
                pages = self.get_download_pages(search_url = download_pages_torrentz2[i], not_in = not_in + ["https://www.google.com/"], start = "http", torrentz2 = True)
                [self.download_pages_torrentz2.append(page) for page in pages]

            link = self.get_download_links(self.download_pages_torrentz2)
            self.links.update(link)

    def get_download_pages(self, search_url, result_url = None, start = None, not_in = None, slice = None, torrentz2 = False):
        request = requests.get(search_url)
        result = BeautifulSoup(request.content, "lxml", parse_only = SoupStrainer("a"))

        download_pages_links = []

        for i in result.find_all("a", href = True):
            if i.get("href").startswith(start) and i.get("href") not in download_pages_links and ("#download" not in i.get("href")):
                
                valid = True

                if torrentz2:
                    if i.get("href") in self.download_pages_torrentz2:
                        continue

                if (start != None) and (not_in != None):
                    for link in not_in:
                        if link in i.get("href"):
                            valid = False

                if valid == True:
                    if result_url != None:
                        if slice != None:
                            download_pages_links.append(f'{result_url}{i.get("href")[slice[0]:slice[1]]}')
                        else:
                            download_pages_links.append(f'{result_url}{i.get("href")}')
                    else:
                        if slice != None:
                            download_pages_links.append(i.get("href")[slice[0]:slice[1]])
                        else:
                            download_pages_links.append(i.get("href"))

        return download_pages_links

    def get_download_links(self, download_pages_links):
        all_magnet_links = []
        magnet_links = {}

        for link in download_pages_links:
            sg.Print(f"Searching in: {link}\n", font=("Segoe UI", 10), no_button=True)
            # print(f"Searching in: {link}\n")

            try:
                request = requests.get(link)
            except:
                print("Something went wrong.")
                continue
            
            result = BeautifulSoup(request.content, "lxml", parse_only = SoupStrainer("a"))

            for i in result.find_all("a", href = True):
            
                if i.get("href").startswith("magnet:?xt="):
                    all_magnet_links.append(i.get("href"))

                for magnet_link in all_magnet_links:
                    if magnet_link not in magnet_links:
                        magnet_links[self.get_torrent_name(magnet_link)] = magnet_link
        
        sg.PrintClose()

        return magnet_links

    def get_torrent_name(self, magnet_link):
        name = magnet_link.split("tr=")[0][64:-1]

        if name.startswith(";dn=") and name.endswith("&amp"):
            name = name[4:-4]

        return urllib.parse.unquote_plus(name)

    def magnets_to_file(self, magnet_links, filename):
        if os.path.exists(os.path.join(Path.home(), "Downloads", "MagnetLinkCatcher")) == False:
            os.mkdir(os.path.join(Path.home(), "Downloads", "MagnetLinkCatcher"))

        path_to_file = os.path.join(Path.home(), "Downloads", "MagnetLinkCatcher")

        with open(os.path.join(path_to_file, f"{filename}.txt"), "w", encoding = "utf-8") as file:
            for name, magnet_link in magnet_links.items():
                file.write(f"{name}\n{magnet_link}\n\n")

        return path_to_file