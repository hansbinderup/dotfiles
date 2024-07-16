import subprocess
import json

def get_active_codec(device_name):
    try:
        pw_dump_output = subprocess.check_output(["pw-dump"], text=True)
        pw_dump_json = json.loads(pw_dump_output)
        for device in pw_dump_json:
            print(json.dumps(device, indent=4))
            if device.get("props", {}).get("node.description") == device_name:
                return device.get("props", {}).get("api.bluez5.codec", "Codec not found")
        return "Device not found: " + device_name
    except subprocess.CalledProcessError:
        return "Error running pw-dump. Make sure PipeWire is installed."

# Replace "Beoplay H95" with your actual device name
device_name = "Beoplay H95"
result = get_active_codec(device_name)
print(result)

