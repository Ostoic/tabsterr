console.log("Tabster loaded");
chrome.webRequest.onHeadersReceived.addListener(
    function(details) {
        console.log(details);
        if(details.url.includes('.js'))
        {
            for (var i = 0; i < details.responseHeaders.length; ++i) {
              if (details.responseHeaders[i].name.toLowerCase() === 'content-type') {
                const name = details.responseHeaders[i].name;
                details.responseHeaders[i] = {name: name, value: 'application/javascript'};
                console.log("Modified Content-Type:", details)
                break;
              }
            }

            return {responseHeaders: details.responseHeaders};
        }
    },
    {urls: [ "https://raw.githubusercontent.com/Ostoic/tabsterr/main/scripts/js/*.js" ] },
    ["blocking", "responseHeaders"]
);

const songsterr_index_js_regex = /https?[:][/]{2}www.songsterr.com[/]static[/]index.([a-zA-Z0-9.]+).js/ig;
chrome.webRequest.onBeforeRequest.addListener(
    function(details) {
        const result = songsterr_index_js_regex.exec(details.url);
        if (result) {
            const index_js_filename = "index." + result[1] + ".js";
            console.log("Redirecting " + index_js_filename + " script");
            let github_index_script = "https://raw.githubusercontent.com/Ostoic/tabsterr/main/scripts/js/" + index_js_filename;
            return {redirectUrl: github_index_script};
        }
    },
    {urls: ["https://www.songsterr.com/static/index.*.js"]},
    ["blocking"]
);