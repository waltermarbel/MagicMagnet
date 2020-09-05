import json


class Settings:
    settings: {}

    def read_settings(self):
        try:
            with open("settings.json", "r") as file:
                self.settings = json.loads(file.read())
        except:
            self.settings = {
                "theme": "MagicMagnetLight",
                "selected": [],
            }

            with open("settings.json", "w") as file:
                data = json.dumps(self.settings, indent=4)
                file.write(data)

        finally:
            return self.settings

    def change_theme(self, theme):
        if self.settings["theme"] != theme:
            self.settings["theme"] = theme

            with open("settings.json", "w") as file:
                data = json.dumps(self.settings, indent=4)
                file.write(data)

                return True

    def generate_metadata(self):
        selected = self.settings['selected'] if 'selected' in self.settings else []
        return {
            'font': 'Segoe UI Light',
            'themeLight': 'Light' in self.settings['theme'],
            'themeDark': 'Dark' in self.settings['theme'],
            'selected': {
                'Google': 'Google' in selected,
                'The Pirate Bay': 'The Pirate Bay' in selected,
                '1337x': '1337x' in selected,
                'Nyaa': 'Nyaa' in selected,
                'Demonoid': 'Demonoid' in selected,
                'YTS': 'YTS' in selected,
                'ETTV': 'ETTV' in selected,
                'EZTV': 'EZTV' in selected,
            }
        }

    def change_selected_engines(self, event, is_selected):
        selected = self.settings['selected'] if 'selected' in self.settings else []
        if is_selected:
            selected.append(event)
        else:
            selected.remove(event)

        self.settings['selected'] = selected

        with open("settings.json", "w") as file:
            data = json.dumps(self.settings, indent=4)
            file.write(data)

            return True
