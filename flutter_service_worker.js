'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "a22b59d1f66751da4cd81021ed59fdcf",
"index.html": "bf11678d63c9975008434b2ca3dc0308",
"/": "bf11678d63c9975008434b2ca3dc0308",
"main.dart.js": "dfa20e813cc1a62402e3039cf177d08a",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "a810e108e5d9bf0ad0d785ab69628e10",
"assets/AssetManifest.json": "7a331a77406a1669d0d59d6800681359",
"assets/NOTICES": "cde639d65495c515da55774b529aa3f7",
"assets/FontManifest.json": "aa527900bf6327c8295df39a0dc8d2bf",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/game_img/level_1/false_horse.png": "c2e4b70c0c8143cbc0e4bad4435b2bd8",
"assets/assets/game_img/level_1/alien_true.png": "49002f377d8b5b3efd268d863a3319b4",
"assets/assets/game_img/level_1/uvaFalse.png": "b63e1ca280779abb69722ba86fa507c6",
"assets/assets/game_img/level_1/uvaTrue.png": "df1a8c10fcc8c806e6288a5e9dfd1577",
"assets/assets/game_img/level_1/fantasmaFalse.png": "8020d9fbedca6879f6a4e8aa3b398b16",
"assets/assets/game_img/level_1/true_horse.png": "5380440f8cafd4d5bcb33a487929cb88",
"assets/assets/game_img/level_1/galinhaFalse.png": "9b150e572045465793bfa0e49b680b07",
"assets/assets/game_img/level_1/galinhaTrue.png": "fabcf5fcc8388c93115578e6790ec8b1",
"assets/assets/game_img/level_1/robot_true.png": "3e0ba5c0cdb983c290e4dbfc0fa7bf96",
"assets/assets/game_img/level_1/snail_true.png": "e506ca448b5dee141ebf52bb57ef9170",
"assets/assets/game_img/level_1/robot_false.png": "91449bcc8072c3b5e9937faab5351c9f",
"assets/assets/game_img/level_1/slug_true.png": "c76d916b901820c7e75859072435dddd",
"assets/assets/game_img/level_1/chaveTrue.png": "a76cd19c51e53acfbe0ca42e5103b306",
"assets/assets/game_img/level_1/bee_false.png": "2c5fc3812336a18870dc21ec6a062826",
"assets/assets/game_img/level_1/fantasmaTrue.png": "a255491ea0fe88dc46b9bddfbe7354d8",
"assets/assets/game_img/level_1/alien_false.png": "a7f2bfc2f2fd273a645dec7b55d69745",
"assets/assets/game_img/level_1/slug_false.png": "caa5ac12c6de23b11e3b22d6c8ba3998",
"assets/assets/game_img/level_1/chaveFalse.png": "dc771457354f3fb0482cc7e65f7a8135",
"assets/assets/game_img/level_1/snail_false.png": "2fdbd207e0729d2c7e930d8a8715a5d3",
"assets/assets/game_img/level_1/bee_true.png": "d33d4c559edc4c94b3ee22878d2f9831",
"assets/assets/img/fundo_atpc.png": "725eaac4e608f76243502cc34d99b635",
"assets/assets/img/ad_sample.png": "f624d0b805db07c0accee5bbe654c11c",
"assets/assets/fonts/Farro/Farro-Regular.ttf": "0663fc17c6aeb01ffe75a312d8ff853d",
"assets/assets/fonts/Lobster/Lobster-Regular.ttf": "c3191f3b933ae0bd46335e178744326e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
