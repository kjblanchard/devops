import os
import json

env_vars = {
    "DNS_ZONES": os.getenv("DNS_ZONES"),
    "ZONE_ID": os.getenv("ZONE_ID"),
    "AWS_ACCESS_KEY_ID": os.getenv("DDNS_AWS_ACCESS_KEY_ID"),
    "AWS_SECRET_ACCESS_KEY": os.getenv("DDNS_AWS_SECRET_ACCESS_KEY")
}

print(json.dumps(env_vars))