'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "aacd84a28797bf28e196e1bde69ac78d",
".git/config": "0909b1e0cf7e440b124a30084e733c00",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "a8d2a80abe73125f8f3a69e5cdcab104",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "b9c6d5e832772904ba1a9fbe8c121ab5",
".git/logs/refs/heads/master": "b9c6d5e832772904ba1a9fbe8c121ab5",
".git/logs/refs/remotes/origin/gh-pages": "9aa1b5199520ee8d154f31a793a6c151",
".git/objects/00/5f734162d56cd8600c523d708ec978d53d9407": "d8f363389b341bbb96d8b99c30de642a",
".git/objects/03/2fe904174b32b7135766696dd37e9a95c1b4fd": "80ba3eb567ab1b2327a13096a62dd17e",
".git/objects/0d/67f0b5e651e5abf926221249e53ea730fd416d": "c92726cdb413b07d06e95406f063bea2",
".git/objects/15/691bc4c8216a92e8423c55222fd4f77862b60b": "5d87ac233e463fd019033e8a001bdb77",
".git/objects/19/ed0e55bfbc9ac98e748a38e35008ff710ac410": "1ca5593e265b47ce9764b1ae9b505c95",
".git/objects/1b/337681d04f8dd7a5d6c476712183215b92c24f": "d53125acf5b04a1b5adc9140a0801f1b",
".git/objects/33/31d9290f04df89cea3fb794306a371fcca1cd9": "e54527b2478950463abbc6b22442144e",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/3b/42c219cdd332b50b31100f42a614080d438454": "9520667e63a2ac1e004a8d6d02c55492",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/4b/da51e972e87c872ebfcd9f98c4d96d4c662730": "baea2f84717e6aad7773cd14d530f1b3",
".git/objects/4c/d0a099feee2ff4b93a4aa9d6e012b26afbc3a8": "61da9a614583973dccc2e78fc996cc9a",
".git/objects/4f/02e9875cb698379e68a23ba5d25625e0e2e4bc": "254bc336602c9480c293f5f1c64bb4c7",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/58/43eaf6506665c3c120adf2b7d36e63984f9f3f": "7c3901c111c022ba84cd697eafe49963",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/64/5116c20530a7bd227658a3c51e004a3f0aefab": "f10b5403684ce7848d8165b3d1d5bbbe",
".git/objects/75/0c9dabe0eca2ad64d9a9e3e28df1eafd6c8c9f": "492aa49683c64bcc52138d0b6e640a67",
".git/objects/81/d4a60ca432b214fd18f0ac50ed1e5dcc95cfdd": "7937029bf564a3eb04dd6ef8fbf9fc0d",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8e/7aa2049032c1b76c64ccec8c9763b135216db9": "0d6f26f02aa550ac97288aeb5b0f0b47",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/96/aebe2df6b3fffdb900528603c8233ecb67df3d": "b31a6f48e8cc2d8d9078d890d128c18e",
".git/objects/9b/c10ac0ae3c4def6894333c711635c0df56d2cc": "06b598f0f2f3244fbc1f7e1755eddffe",
".git/objects/9d/6a676a54168e5427f85eec28bba020632386c0": "009479c332a46f17ba874e3e2f7bb9f6",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/a8/1f99244a46beb7eda375be4c45fbb471d29669": "801ef40c003fc09eadd8578fb10ae799",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/ab/8562c10f108d1092a0a9a7288b269484bec710": "80914cab4e0e9983e298251c80ce039c",
".git/objects/ac/5fd5d5c666ac78c797c35daca5039fa23af065": "d02bcb25f55283db7e242b3f812700bf",
".git/objects/ae/68310c508beb61e2dc0effdae7930d0599201c": "3d99d31f15e2a4cfa65b65e56f65fb5b",
".git/objects/b4/2233db9a4f76c77ca1e1e415d1976a4fa08bcd": "522cf6dd5a8a7593b94912a86703018b",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/7d5c0702da6aaab232ca5b6957c2393cdae93a": "b532406e0831dc25170b8a65b5828c09",
".git/objects/c5/490b9ebe5a807f98b9318af1e1cf95bbddf098": "02e0cc6cff8e766a3fedddec651f9fd9",
".git/objects/c7/921c5a67c70b256e2237b8d5b952a82f3b7f65": "1599226023cc42fdcffe92c70368fb99",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/e9/8eb839b6d4ea73e99efe0bb46cd0f4389395cc": "4a323a97bd13ab6403686dd2ae2b131b",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/f9/eb3d7367a404c81f84fdbd80fb6ddc7a12e657": "de457c089d703637085916da93ddd0e4",
".git/objects/fd/8766b00b876465b958b85af5c95076ab614616": "f8b513a6b822743821b684d56dfda447",
".git/objects/fe/e4d6c68e230b53f04efe34882ca8548033e1ec": "b7fd2d5895aa718b51ff631854e2947a",
".git/refs/heads/master": "b7f30cef1000bd3ca84f037c9fa66412",
".git/refs/remotes/origin/gh-pages": "b7f30cef1000bd3ca84f037c9fa66412",
"assets/AssetManifest.bin": "ac0737ffccd0ea979822c2d749672246",
"assets/AssetManifest.bin.json": "ee21da6b4442586a007b8f52fea525ac",
"assets/AssetManifest.json": "8f196614d16d6246397ee2b13124795c",
"assets/assets/google.png": "c8bf7c087ca9793d094042845707ffac",
"assets/assets/Imagen1.jpg": "fe5542392a5c46cc58c76b7a5032ea06",
"assets/assets/Imagen2.png": "f4402c2927376b7181519a80139f30ee",
"assets/assets/Imagen3.jpg": "98bcb6dbc83407d0e7397bb2cfd9b9e2",
"assets/assets/Imagen3.png": "b7e54c09ed20b196d667bce643e50e36",
"assets/assets/Imagen4.png": "3ea27f53afe9aa2ee804e6ccfcbba91a",
"assets/assets/Imagen5.png": "0dadd74469aa4e1b4291495317000da6",
"assets/assets/Imagen6.jpg": "a1e2209a987b8e19ddeed7e949cb9bd5",
"assets/assets/Imagen7.jpg": "0622930732f7d1e961994400180ae6bc",
"assets/assets/Imagen8.jpg": "2d2194416d9164b8f105f33ed9ce7a33",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "2b564d9b8808aa6f565e051ba607a218",
"assets/NOTICES": "465ec9d35792087a7e3b39753b5e172a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "9ddea42b6526ae3b77a9b64128626e15",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "af94a7261e4e1285091d7fc428b63368",
"/": "af94a7261e4e1285091d7fc428b63368",
"main.dart.js": "72370abf248c1e4fa84025f8a42b7cff",
"manifest.json": "713e187590a2f36650a2f2efbacbf034",
"version.json": "ae9944780a1a6239ee72e93814337491"};
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
