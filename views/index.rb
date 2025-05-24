<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ASCII Art Output</title>
  <link rel="stylesheet" href="/styles.css">
</head>
<body>
  <div class="container">
    <h1>ASCII Art Output</h1>
    
    <div class="controls">
      <button id="copyButton">Copy to Clipboard</button>
    </div>
    
    <div class="ascii-display" id="asciiDisplay">
      <pre id="asciiArt">Waiting for ASCII art...</pre>
    </div>
  </div>
  
  <script>
    // Connect to SSE stream
    const eventSource = new EventSource('/updates');
    const asciiArt = document.getElementById('asciiArt');
    const copyButton = document.getElementById('copyButton');
    
    // Handle incoming updates
    eventSource.onmessage = function(event) {
      const data = JSON.parse(event.data);
      if (data.ascii) {
        asciiArt.textContent = data.ascii;
      }
    };
    
    // Handle errors
    eventSource.onerror = function() {
      asciiArt.textContent = 'Connection to server lost. Please refresh the page.';
      eventSource.close();
    };
    
    // Copy to clipboard functionality
    copyButton.addEventListener('click', function() {
      const selection = window.getSelection();
      const range = document.createRange();
      range.selectNodeContents(asciiArt);
      selection.removeAllRanges();
      selection.addRange(range);
      
      try {
        document.execCommand('copy');
        const originalText = copyButton.textContent;
        copyButton.textContent = 'Copied!';
        setTimeout(() => {
          copyButton.textContent = originalText;
        }, 2000);
      } catch (err) {
        console.error('Failed to copy: ', err);
      }
      
      selection.removeAllRanges();
    });
  </script>
</body>
</html>