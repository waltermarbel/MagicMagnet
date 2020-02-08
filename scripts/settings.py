import json

class Settings():
    def read_settings(self):
        try:
            with open("settings.json", "r") as file:
                settings = json.loads(file.read())
        except:            
            settings = {
                "theme": "MagnetLinkCatcherLight"
            }
            
            with open("settings.json", "w") as file:
                data = json.dumps(settings, indent = 4)
                file.write(data)

        finally:
            return settings
    
    def change_theme(self, theme):
        settings = self.read_settings()

        if settings["theme"] != theme:
            settings["theme"] = theme

            with open("settings.json", "w") as file:
                data = json.dumps(settings, indent = 4)
                file.write(data)

                return True