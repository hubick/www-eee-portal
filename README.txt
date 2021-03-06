WWW-EEE Portal
--------------

WWW-EEE Portal allows you to generate your own simple web portal.

Technically speaking, it's an XSLT file which transforms an OPML file (XML listing of content URL's) into an HTML file containing an iframe for each URL, plus navigation.


Features
--------

- Define your portal using a single OPML (XML) file, listing the URL's for your content.
- The generated portal is a single self-contained static HTML file, with no server-side software or 3rd-party libraries required.
- The entire implementation is contained within a single XSLT transformation file, open source (AGPL), and available for customization.
- Provides content-grouping pages with tabbed navigation, and a flexible layout which scales from mobile to desktop browsers.
- The generated portal utilizes the latest HTML standards, Scalable Vector Graphics (SVG), and comes with full support for accessibility and keyboard navigation.
- All portal content is aggregated on the client side by the browser (using iframes), which won't break site features like server side aggregation does.
- Extremely secure, with all content fully sandboxed by default, and with the generated portal itself utilizing no javascript.
- Includes a neutral default theme which can be easily customized or completely replaced.


Configuration
-------------

The primary thing you will need is to create an OPML XML file pointing to the content for your portal, the structure of which should look something like this:

---------------------index.opml-----------------------------------------
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="https://raw.githubusercontent.com/hubick/www-eee-portal/master/www-eee-portal.xsl"?>
<opml version="1.0">
  <head>
    <title>My Portal</title>
    <ownerName>My Organization/Name</ownerName>
    <ownerEmail>email@example.com</ownerEmail>
    <ownerId>http://www.example.com/</ownerId>
  </head>
  <body>
    <outline text="Welcome">
      <outline type="link" text="About" url="http://www.example.com/portal/about.html" />
      <outline type="link" text="Hello" url="http://www.example.com/portal/hello.html" sandbox="allow-popups allow-popups-to-escape-sandbox" />
    </outline>
    <outline text="Stuff">
      <outline type="link" text="Big Stuff" url="big.html" />
      <outline type="link" text="Small Stuff" url="small.html" />
    </outline>
    <outline text="Example">
      <outline type="text" text="Text Example">Hello World &amp; Aliens!</outline>
      <outline type="xhtml" text="XHTML Example">
        <p xmlns="http://www.w3.org/1999/xhtml">Hello <b>World</b> &amp; Aliens!</p>
      </outline>
      <outline type="html" text="HTML Example">&lt;p&gt;Hello &lt;b&gt;World&lt;/b&gt; &amp;amp; Aliens!&lt;/p&gt;</outline>
    </outline>
  </body>
</opml>
------------------------------------------------------------------------

Note the second line, which is a link to the latest stable online release of WWW-EEE Portal. You can also download a specific release to your server and modify the link to point there.

You can place your .opml file on your web server, and browsers should apply the portal transformation and display the resulting HTML content to the user. Currently, for compatibility reasons, it's best to ensure .opml and .xsl files are both served with a 'Content-Type: application/xml' HTTP header.

You may wish to name your .opml file 'index.opml' or 'default.opml' and configure your web server to serve those by default for a directory (e.g. at the root).

The generated portal references a 'favicon.svg' file (in the same directory) by default, which should either be provided by you, or customized to be disabled.


Customization
-------------

If you wish to customize the default theme (colors, etc) or portal settings (channel title links, etc), you will either need to modify the 'www-eee-portal.xsl' file (not advised, since you would need to redo those changes following any update to a newer portal release), or use it to transform your OPML to HTML ahead of time, and host the resulting .xhtml file on your web server (instead of the .opml and .xsl).

One way to apply an XSLT transformation ahead of time is to use the 'xsltproc' command line utility provided by the Libxslt project ( http://xmlsoft.org/XSLT/ ), which is available for most platforms.

You can invoke this manually each time (after updates to the .opml or .xsl), or save your custom parameters in a small shell script:

---------------------generate_portal.sh---------------------------------
xsltproc -o index.xhtml \
  --stringparam www-eee-body-background 'black' \
  --stringparam www-eee-body-color 'white' \
  'www-eee-portal.xsl' index.opml
------------------------------------------------------------------------

See the top of the 'www-eee-portal.xsl' file for documentation on all the parameters available.


Includes
--------

You can use the 'www-eee-includes-document' parameter to to perform more extensive customization of your portal by specifying the location of an .xhtml file to include additional content from (e.g. '--stringparam www-eee-includes-document 'portal-includes.xhtml''), the structure of which should look something like this:

---------------------portal-includes.xhtml------------------------------
<?xml version="1.0" encoding="UTF-8"?>
<html xmlns="http://www.w3.org/1999/xhtml">

<ol id="header_links">
  <li><a href="http://www.example.com/" target="_blank" tabindex="20000">Header Link 1</a></li>
  <li><a href="http://www.example.com/" target="_blank" tabindex="20000"><img src="favicon.svg" alt="example" /></a></li>
</ol>

<ol id="footer_links">
  <li><a href="http://www.example.com/" target="_blank" tabindex="60000">Footer Link 1</a></li>
  <li><a href="http://www.example.com/" target="_blank" tabindex="60000">Footer Link 2</a></li>
</ol>

<style class="custom_style">
<![CDATA[

div#portal_title {
  background-color: red;
}

]]>
</style>

<style class="custom_style_group_nav_item_checked">
<![CDATA[

  background-color: blue;

]]>
</style>

</html>
------------------------------------------------------------------------

As you can see, this will allow you to provide additional links for the header/footer (the default theme provides styling for these, including nested images), or supply a style block to augment or entirely replace the default theme (see 'www-eee-default-theme-disable' param).

