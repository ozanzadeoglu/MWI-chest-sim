'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "f05fe50f829e05bf88970fbba5f36426",
"assets/AssetManifest.bin.json": "813dbcc677220d50bc8cea3f8507dfa6",
"assets/AssetManifest.json": "8791535214f9d936b66415827eecf7c0",
"assets/assets/images/background.png": "eb75f24300f7023555148fb6cb2459d5",
"assets/assets/svgs/acrobatic_hood.svg": "2ffd4087d02b9551d0454e9579870be1",
"assets/assets/svgs/acrobats_ribbon.svg": "fc73c8142e5d47433d784e72de501cf8",
"assets/assets/svgs/amethyst.svg": "d7dfe5d13277e6a9882322250094df0a",
"assets/assets/svgs/apple.svg": "6d2373fdb9723420ea3fdf8eefcbda0c",
"assets/assets/svgs/arcane_reflection.svg": "ffe4b7c39ae512f3ce4e627ed859f752",
"assets/assets/svgs/background.svg": "2921929eba92f958c9e88c03941570b7",
"assets/assets/svgs/bishops_codex.svg": "8aa2219151082ebc90adacc5132a4ec7",
"assets/assets/svgs/bishops_scroll.svg": "43e0ab4b4d2d176bb7d33b529df1b3e8",
"assets/assets/svgs/chaotic_chain.svg": "2cf50c3dde209ce2ecaf6dfb4f458c1b",
"assets/assets/svgs/chaotic_flail.svg": "3bc9aedc2bf4bb87c788afda934bc3ed",
"assets/assets/svgs/chimerical_chest.svg": "e7a5063d9c1ef56c91b885ae61a0d526",
"assets/assets/svgs/chimerical_chest_key.svg": "0034ee39f4aa2888d307585117296dfb",
"assets/assets/svgs/chimerical_entry_key.svg": "1fd895520237dc239ce69b32da25320b",
"assets/assets/svgs/chimerical_essence.svg": "25ca274841b86620f98ee5b1dc4b46a6",
"assets/assets/svgs/chimerical_quiver.svg": "0fd084f5edd82a50e5b018a2488ff329",
"assets/assets/svgs/chimerical_token.svg": "891324ae12538770dba27c71a2a666b7",
"assets/assets/svgs/coin.svg": "f67364a50cf65445498811a3f34e195c",
"assets/assets/svgs/crippling_slash.svg": "4c7cf61acd386913909a1546855bda31",
"assets/assets/svgs/cursed_ball.svg": "f183e54e1665e305e2f4b8d012244229",
"assets/assets/svgs/cursed_bow.svg": "246dd551f208c490ecf1586a9444d599",
"assets/assets/svgs/dodocamel_gauntlets.svg": "af6358486cebecca20eb7299879821a4",
"assets/assets/svgs/dodocamel_plume.svg": "a02f23d61beb41ba331eb166af8f9b14",
"assets/assets/svgs/enchanted_chest.svg": "409e0832bee7233d6701769dd512dce5",
"assets/assets/svgs/enchanted_chest_key.svg": "5ff3278abbb1ca0ba592e47e95bf3723",
"assets/assets/svgs/enchanted_cloak.svg": "b7b86a8ee1a50f40b1fd8f3356d41a93",
"assets/assets/svgs/enchanted_entry_key.svg": "ca3f85422747e7ad0cdf6a295bd2c537",
"assets/assets/svgs/enchanted_essence.svg": "72b290c68ae04076bd1e845becbe99e8",
"assets/assets/svgs/enchanted_token.svg": "91236bcea0c1b8b8be83e3b42139b7e7",
"assets/assets/svgs/garnet.svg": "25e361947e6b6e576aec48ab1f493ec8",
"assets/assets/svgs/griffin_bulwark.svg": "0883628f7ed611ae7c2c9a4fc1fa18f4",
"assets/assets/svgs/griffin_chaps.svg": "ef336b4c8cb715374068e51711ca30b3",
"assets/assets/svgs/griffin_leather.svg": "be0ff2c64c6f1195dc5017e4e5ea1a38",
"assets/assets/svgs/griffin_talon.svg": "c9d9fecbaed19f7f475ee8ab0dc1fb98",
"assets/assets/svgs/griffin_tunic.svg": "41d70d5860d27bed7d0c8442947e643d",
"assets/assets/svgs/jackalope_antler.svg": "c32321120e9968a6bc5591712b56bb5a",
"assets/assets/svgs/jackalope_staff.svg": "a628e4a7efb73031994377bde8947a57",
"assets/assets/svgs/jade.svg": "a4993e45bb4e2e6dfac3672d0fd51d83",
"assets/assets/svgs/knights_aegis.svg": "4774d59da54470f49d84bffcd005c711",
"assets/assets/svgs/knights_ingot.svg": "9ca0fbfd2cb82ec26fd2619a9ed58039",
"assets/assets/svgs/large_treasure_chest.svg": "9355cac2bd21c9ae8dcce100a5b89af1",
"assets/assets/svgs/magicians_cloth.svg": "4c7644a09438873b1ef26cac5ceddfd0",
"assets/assets/svgs/magicians_hat.svg": "87d9a356a53a7f57bc4412a70e624ea9",
"assets/assets/svgs/mana_spring.svg": "e28f8947f42bc44162511748459bf3f5",
"assets/assets/svgs/manticore_shield.svg": "37c60634847df1652151465970538032",
"assets/assets/svgs/manticore_sting.svg": "1d2c0011fd9f0aff117c3ade42e49e00",
"assets/assets/svgs/penetrating_shot.svg": "9f05106322fcb74198f937288a9d0a8c",
"assets/assets/svgs/penetrating_strike.svg": "a4b484da2ce72988ff75ed46d808231e",
"assets/assets/svgs/pestilent_shot.svg": "44c36141770784f080d1c7f12057f2b7",
"assets/assets/svgs/regal_jewel.svg": "ba32868343b25837b212801ae41a0084",
"assets/assets/svgs/regal_sword.svg": "4a4f44654f73568df0820b7f1450784d",
"assets/assets/svgs/royal_cloth.svg": "da51e5370ee6e5d40e19fa680b0a8058",
"assets/assets/svgs/royal_fire_robe_bottoms.svg": "b630c66a0a11a5709a3ef30d36293a95",
"assets/assets/svgs/royal_fire_robe_top.svg": "23b61a7b8b1a63aaeaf1db12ef845bd4",
"assets/assets/svgs/royal_nature_robe_bottoms.svg": "a3a133d9dd327461c13481fd436af826",
"assets/assets/svgs/royal_nature_robe_top.svg": "f3ce651fc9d35d66c831dbae3cebbc95",
"assets/assets/svgs/royal_water_robe_bottoms.svg": "5813f1354734367956f8cc2bdfaf0983",
"assets/assets/svgs/royal_water_robe_top.svg": "a1afbf0f3e9b2fad852d09c7af38ed29",
"assets/assets/svgs/sinister_cape.svg": "c9e3d67b47b416f7b4d77b8013257775",
"assets/assets/svgs/sinister_chest.svg": "f1cbe45a97e38eee1e0fb429c265c896",
"assets/assets/svgs/sinister_chest_key.svg": "80b37e9ea1ffa4a9febb430adeab13f5",
"assets/assets/svgs/sinister_entry_key.svg": "a0676328c51b1646d61bd76d01ede6bf",
"assets/assets/svgs/sinister_essence.svg": "30520a3422051476efbd3c72fa4dae74",
"assets/assets/svgs/sinister_token.svg": "922bb67ea8e8ad79b1c39f2419209f2b",
"assets/assets/svgs/smoke_burst.svg": "caec418e43764b15e38a61b8a684c6f7",
"assets/assets/svgs/sundering_crossbow.svg": "8b54db65c0051507ffea0a1d320327be",
"assets/assets/svgs/sundering_jewel.svg": "f23a42623648f288a5ebb3bb90f4c3e3",
"assets/assets/svgs/sunstone.svg": "dd3e21e83557edfe3e0854cc662b8e6b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "9e101dacd2813d3c8a7cf21ff985d726",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "2d00617a7a246cb186009c13bfa028f3",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "4ff64a53de5d361abe0314be14dd43ac",
"/": "4ff64a53de5d361abe0314be14dd43ac",
"main.dart.js": "c9b5a7c9df22cd718c516bd56062a2ce",
"manifest.json": "33798b8f3f69bf917e3666e4bac47510",
"version.json": "6a7b88d4cf2c3005e8cb3e6f960f98ef"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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