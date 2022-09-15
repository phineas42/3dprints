import re

from ..Script import Script


class VarySpeedWithHeight(Script):
    """Adjust the speed to assess optimal print speed for a given filament
    """

    def getSettingDataString(self):
        return """{
            "name": "Vary Speed With Height",
            "key": "VarySpeedWithHeight",
            "metadata": {},
            "version": 2,
            "settings":
            {
                "lowSpeed":
                {
                    "label": "Starting speed",
                    "description": "Starting speed",
                    "type": "float",
                    "default_value": 20
                },
                "speedIncrement":
                {
                    "label": "Speed Increment",
                    "description": "Adjust speed in steps this large",
                    "type": "float",
                    "default_value": 10
                },
                "layerIncrement":
                {
                    "label": "Layer Increment",
                    "description": "Adjust speed after each this many layers",
                    "type": "float",
                    "default_value": 40
                }
            }
        }"""

    def execute(self, data):
        lowSpeed = self.getSettingValueByKey("lowSpeed")
        speedIncrement = self.getSettingValueByKey("speedIncrement")
        layerIncrement = self.getSettingValueByKey("layerIncrement")
        currentSpeed = lowSpeed
        for layer_number, layer in enumerate(data):
            speedFactor = (lowSpeed + speedIncrement*(layer_number//layerIncrement))/lowSpeed
            newLayerLines=[]
            for line in layer.splitlines():
                modified_line = re.sub('^(G[01]\s(?:[^;]*\s)?)F(\d+(?:\.\d*)?)(\s(?:[^;]*\s)?E\d+(?:\.\d*)?)',
                                       lambda m: '{}F{}{}'.format(m.group(1), speedFactor*float(m.group(2)), m.group(3)),
                                       line)
                newLayerLines.append(modified_line)
            data[layer_number] = "\n".join(newLayerLines)
        return data
