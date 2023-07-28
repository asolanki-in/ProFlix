# ProFlix - A Simple IPTV App
An IPTV Player Built with SwiftUI + Swift (Only IPAD now. Planning to build it for iPhone & AppleTV Platform)

#### This is a simple SwiftUI project. It accept m3u urls and manage multiple streams in core data. The user can play his favourite streams on IPAD.

* Simple UI
* Quick Play and Library Management
* Recent & Favourite Stream (not completed)
* Protected Stream (not completed - think of some stream that is only provide for you and is password protected :lock: )

Code is pretty basic in terms of architecture. Feel free to update. Here is a screenshot

![screenshot](https://raw.githubusercontent.com/asolanki-in/ProFlix/main/screenshot.png)


### Feel Free to Contribute
Reach me out for any query.

 lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="https://code.jquery.com/jquery-3.7.0.slim.min.js"></script>
  </head>
  <body>
    <input type="file" id="file-selector" name="my-input" class="hidden" />
    <script>
      $("#file-selector")[0].onchange = onSelectedFileChange;

      function onSelectedFileChange(e) {
        readFile(e.target.files[0]);
      }

      function readFile(file) {
        const reader = new FileReader();
        reader.readAsDataURL(file);

        reader.addEventListener("load", (event) => {
          const result = event.target.result;
          alert("Now Upload");
          $("#file-selector").val('');
        });

        reader.addEventListener("progress", (event) => {
          if (event.loaded && event.total) {
            const percent = (event.loaded / event.total) * 100;
            console.log(`Progress: ${Math.round(percent)}`);
          }
        });
      }
    </script>
  </body>
</html>
