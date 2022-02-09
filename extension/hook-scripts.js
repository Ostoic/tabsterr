console.log("Tabster loaded");
chrome.webRequest.onHeadersReceived.addListener(
    function(details) {
        // if (!details.responseHeaders) {
        //     return;
        // }

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

// const github_script_regex = /https?[:][/]{2}raw.githubusercontent.com[/]Ostoic[/]random-scripts[/]main[/]([a-zA-Z0-9.]+.js)/ig;
// const songsterr_script_regex = /https?[:][/]{2}www.songsterr.com[/]static[/]([a-zA-Z0-9.]+.js)/ig;

chrome.webRequest.onBeforeRequest.addListener(
    function(details) {
        // const result = songsterr_script_regex.exec(details.url);
        // if (result) {
        //     console.log("Redirecting script");
        //     return {redirectUrl: "https://www.songsterr.com/static/" + result[1]};
        // }
        if (details.url == "https://www.songsterr.com/static/index.52ddb71b.js")
        {
            return {redirectUrl: "https://raw.githubusercontent.com/Ostoic/tabsterr/main/scripts/js/index.52ddb71b.js" };
        }
    },
    {urls: ["https://www.songsterr.com/static/index.52ddb71b.js"]},
    ["blocking"]
);