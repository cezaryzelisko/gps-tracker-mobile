var config = {
  "endpoints": {
    // "root": "http://127.0.0.1:8000",
    "root": "http://192.168.1.102:8000",
    "api": {
      "gps_footprint": "gps-footprint/",
      "device": "device/",
    },
    "auth": {
      "obtain_token": "token/",
      "refresh_token": "token/refresh/",
    }
  },
  "auth": {
    "access_token_lifetime": 3600,
    "refresh_token_lifetime": 86400,
  }
};
