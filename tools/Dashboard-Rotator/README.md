# Dashboard Rotator

A simple HTML file that can be used to rotate all your favourite Open Access dashboards without the use of browser plugins.
As long as simple scripts can be executed by the browser, should do the trick.

---
## Setup

1. Copy `rotate.html` into the root of your IIS directory i.e. C:\inetpub\wwwroot
2. Edit the array of URLs to be rotated through (line 25)
3. Set the desired time between rotations, in milliseconds (line 40)

---
## Usage

1. Go to the URL i.e. `https://your-server.domain.local/rotator.html`
2. Marvel at your greatness

---
## Notes

* If your SquaredUp server is accessed via HTTPS, this page must be hosted on a server also using HTTPS. HTTPS embedding into a HTTP page doesn't go very well. Hosting this on your SquaredUp server is the simplest approach.

* If you want to provide different sets of dashboards on rotation for different screens, just create multiple copies of `rotate.html` to suit each case, uniquely named i.e. `rotate-screen-1.html`, `rotate-screen-2.html`, then go to the correct URL on each screen.
