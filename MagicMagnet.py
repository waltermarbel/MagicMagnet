import PySimpleGUI as sg
import os
import pyperclip
from scripts.algorithm import MagicMagnet
from scripts.settings import Settings
from scripts.engines import enginesList

sg.LOOK_AND_FEEL_TABLE['MagicMagnetLight'] = {
    'BACKGROUND': 'white',
    'TEXT': '#323232',
    'INPUT': '#dfe2e8',
    'TEXT_INPUT': '#000000',
    'SCROLL': '#c7e78b',
    'BUTTON': ('white', '#FF4D00'),
    'PROGRESS': ('white', 'black'),
    'BORDER': 0, 'SLIDER_DEPTH': 0, 'PROGRESS_DEPTH': 0,
}

sg.LOOK_AND_FEEL_TABLE['MagicMagnetDark'] = {
    'BACKGROUND': '#212121',
    'TEXT': '#b3b3b3',
    'INPUT': '#dfe2e8',
    'TEXT_INPUT': '#121212',
    'SCROLL': '#c7e78b',
    'BUTTON': ('white', '#FF4D00'),
    'PROGRESS': ('white', 'black'),
    'BORDER': 0, 'SLIDER_DEPTH': 0, 'PROGRESS_DEPTH': 0,
}

settings = Settings()
settings.read_settings()
meta = settings.generate_metadata()
font = meta.get('font')
engines = meta.get('selected')

sg.change_look_and_feel(settings.settings['theme'])

mainLayout = [
    [sg.Text('\n', font=(font, 5))],
    [sg.Text('  Magic Magnet', font=(font, 24), text_color='#FF4D00',
             justification='left'), sg.Image('icon.png')],
    [sg.Text('    Search for something', font=(font, 14))],
    [sg.Text('\n', font=(font, 1))],
    [sg.Text('  '), sg.InputText(size=(28, 6), font=(font, 12)), sg.VerticalSeparator(
        pad=(4, (3, 4))), sg.Submit('Search', size=(12, 0), font=(font, 10, 'bold'))],
    [sg.Text('\n', font=(font, 1))],
    [sg.Text('    Choose your search source for content', font=(font, 14))],
    [sg.Text('\n', font=(font, 1))],
    [sg.Text('  '), sg.Checkbox('Google', key='Google', font=(font, 12), size=(11, 1), default=engines['Google'], enable_events=True),
     sg.Checkbox('The Pirate Bay', key='The Pirate Bay', font=(font, 12), size=(
         16, 1), default=engines['The Pirate Bay'], enable_events=True),
     sg.Checkbox('1337x', key='1337x', font=(font, 12), default=engines['1337x'], enable_events=True)],
    [sg.Text('  '), sg.Checkbox('Nyaa', key='Nyaa', font=(font, 12), size=(11, 1), default=engines['Nyaa'], enable_events=True),
     sg.Checkbox('Demonoid', key='Demonoid', font=(font, 12), size=(
         16, 1), default=engines['Demonoid'], enable_events=True),
     sg.Checkbox('YTS', key='YTS', font=(font, 12), default=engines['YTS'], enable_events=True)],
    [sg.Text('  '), sg.Checkbox('SkyTorrents', key='SkyTorrents', font=(font, 12), size=(11, 1), default=engines['SkyTorrents'], enable_events=True), sg.Checkbox('LimeTorrents', key='LimeTorrents', font=(
        font, 12), size=(16, 1), default=engines['LimeTorrents'], enable_events=True), sg.Checkbox('ETTV', key='ETTV', font=(font, 12), size=(11, 1), default=engines['ETTV'], enable_events=True)],
    [sg.Text('  '), sg.Checkbox('EZTV', key='EZTV', font=(font, 12), size=(
        16, 1), default=engines['EZTV'], enable_events=True)],
    [sg.Text('\n', font=(font, 1))],
    [sg.Text(f'    Application theme', font=(font, 14)), sg.Radio('Light', 'theme', key='LightSkin', default=meta.get('themeLight'), font=(font, 12)), sg.Radio(
        'Dark', 'theme', key='DarkSkin', default=meta.get('themeDark'), font=(font, 12)), sg.Button('Apply', size=(7, 0), font=(font, 10, 'bold'))],
    [sg.Text('\n', font=(font, 1))],
    [sg.Text('  '), sg.Button('Support this project', size=(17, 0), font=(font, 10, 'bold')), sg.VerticalSeparator(pad=(6, 3)), sg.Button(
        'About', size=(7, 0), font=(font, 10, 'bold')), sg.VerticalSeparator(pad=(6, 3)), sg.Button('Exit', size=(12, 0), font=(font, 10, 'bold'))],
    [sg.Text('\nDeveloped by Pedro Lemos (@pedrolemoz)',
             font=(font, 12), size=(42, 0), justification='center')]
]

window = sg.Window('Magic Magnet', mainLayout,
                   size=(430, 540), icon='icon.ico')  # default: 510

process = MagicMagnet()

while True:
    event, values = window.read()

    if event in (None, 'Exit'):
        window.close()
        break

    if event in enginesList:
        settings.change_selected_engines(event, values[event])

    if event == 'Apply':
        status = False

        if values['LightSkin']:
            status = settings.change_theme('MagicMagnetLight')

        elif values['DarkSkin']:
            status = settings.change_theme('MagicMagnetDark')

        if status:
            restartLayout = [
                [sg.Text('\n', font=(font, 5))],
                [sg.Text('Restart to apply changes', font=(font, 14),
                         size=(20, 0), justification='left')],
                [sg.Text('\n', font=(font, 1))]
            ]

            restartWindow = sg.Window(
                'Success!', restartLayout, auto_close=True, icon='icon.ico')

            restartEvent, restartResult = restartWindow.read()

    if event == 'Support this project':
        os.startfile('https://github.com/pedrolemoz/MagicMagnet-Python/')

    if event == 'About':
        aboutLayout = [
            [sg.Text('\n', font=(font, 1))],
            [sg.Text('This project was born with an idea for automatize torrent downloading.\nI don\'t wanna search for torrent and see boring adverts. This program search on many sources and return all found magnet links and is able to start the default torrent application, copy links and save its to file.\n\nNotorious people that contributed to this project:\n\nPedro Lemos (@pedrolemoz) [Owner]\nMiguel Magalhães Lopes (@mzramna)\nSamuel Belloulou (@bosam)\nNicolei Ocana (@nicoleiocana\ndelivey (@delivey)', font=(
                'Segoe UI', 12), size=(56, 0), justification='left')],
            [sg.Text('\n', font=(font, 1))],
            [sg.Text(' ' * 101), sg.Button('Close',
                                           size=(12, 0), font=(font, 10, 'bold'))],
            [sg.Text('\n', font=(font, 1))]
        ]

        aboutWindow = sg.Window('About project', aboutLayout, icon='icon.ico')

        while True:
            aboutEvent, aboutValues = aboutWindow.read()
            if aboutEvent in (None, 'Close'):
                aboutWindow.close()
                break

    if event == 'Search':
        process.search(values[1], google=values['Google'], tpb=values['The Pirate Bay'], l337x=values['1337x'],
                       nyaa=values['Nyaa'], demonoid=values['Demonoid'], yts=values['YTS'], skytorrents=values['SkyTorrents'],
                       limetorrents=values['LimeTorrents'], ettv=values['ETTV'], eztv=values['EZTV'])

        downloadLinks = []

        [downloadLinks.append(
            i) if i != 'foundLinks' else None for i in process.links.keys()]

        results_Layout = [
            [sg.Text('\n', font=(font, 5))],
            [sg.Text('Process finished successfully!', font=(
                font, 14), size=(30, 0), justification='left')],
            [sg.Text('\n', font=(font, 1))],
            [sg.Listbox(values=downloadLinks, size=(90, 15),
                        font=('Segoe UI', 10), enable_events=True)],
            [sg.Text('\n', font=(font, 1))],
            [sg.Text(' ' * 16), sg.Button('Save all links to file', size=(22, 0), font=(font, 10, 'bold')), sg.Button('Open magnet link', size=(16, 0), font=(
                font, 10, 'bold')), sg.Button('Copy magnet link', size=(16, 0), font=(font, 10, 'bold')), sg.Button('Close', size=(12, 0), font=(font, 10, 'bold'))],
            [sg.Text('\n', font=(font, 1))]
        ]

        sg.PrintClose()

        resultsWindow = sg.Window('Success!', results_Layout, icon='icon.ico')

        while True:
            resultsEvent, resultsValues = resultsWindow.read()

            if resultsEvent in (None, 'Close'):
                process.links, downloadLinks = {}, []
                process.links['foundLinks'] = 0
                resultsWindow.close()
                break

            if resultsEvent == 'Save all links to file':
                process.magnetsToJSON(values[1])

                saveLayout = [
                    [sg.Text('\n', font=(font, 5))],
                    [sg.Text(f'Magnet links saved successfully!', size=(
                        25, 0), font=(font, 14), justification='left')],
                    [sg.Text('\n', font=(font, 1))],
                    [sg.Text(' ' * 6), sg.Button('Open file', size=(12, 0), font=(font, 10,
                                                                                  'bold')), sg.Button('Close', size=(12, 0), font=(font, 10, 'bold'))],
                    [sg.Text('\n', font=(font, 1))]
                ]

                saveWindow = sg.Window('Success!', saveLayout, icon='icon.ico')

                while True:
                    saveEvent, saveResult = saveWindow.read()

                    if saveEvent in (None, 'Close'):
                        saveWindow.close()
                        break

                    if saveEvent == 'Open file':
                        os.startfile(os.path.join(
                            os.getcwd(), 'json', f'{values[1]}.json'))

            if resultsEvent == 'Open magnet link':
                os.startfile(process.links[resultsValues[0][0]])

            if resultsEvent == 'Copy magnet link':
                pyperclip.copy(process.links[resultsValues[0][0]])

                clipboardLayout = [
                    [sg.Text('\n', font=(font, 5))],
                    [sg.Text('Copied to clipboard!', font=(font, 14),
                             size=(17, 0), justification='left')],
                    [sg.Text('\n', font=(font, 1))]
                ]

                clipboardWindow = sg.Window(
                    'Success!', clipboardLayout, auto_close=True, icon='icon.ico')

                clipboardEvent, clipboard_result = clipboardWindow.read()
