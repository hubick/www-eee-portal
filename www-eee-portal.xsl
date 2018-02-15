<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright 2017-2018 by Chris Hubick <chris@hubick.com>. All Rights Reserved. This work is licensed under the terms of the "GNU AFFERO GENERAL PUBLIC LICENSE" version 3, as published by the Free Software Foundation <http://www.gnu.org/licenses/>. -->
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" media-type="application/xhtml+xml" method="xml" omit-xml-declaration="no" doctype-system="about:legacy-compat" />

  <!-- If an includes document is specified it will be parsed for content to be included in the appropriate sections. -->
  <!-- Current includes are "//html:html/html:ol[@id='header_links']", "//html:html/html:ol[@id='footer_links']", "//html:html/html:style[@class='custom_style']", "//html:html/html:style[@class='custom_style_group_nav_item_focus']", "//html:html/html:style[@class='custom_style_group_nav_label_focus']", "//html:html/html:style[@class='custom_style_group_nav_item_checked']", "//html:html/html:style[@class='custom_style_group_nav_label_checked']". -->
  <xsl:param name="www-eee-includes-document" />

  <!-- Should the favicon.svg head link and heading image be disabled? -->
  <xsl:param name="www-eee-favicon-disable" select="'false'" />

  <!-- Should the channel titles not be made into links to the channel content URL's? -->
  <xsl:param name="www-eee-channel-title-link-disable" select="'false'" />

  <!-- The channel content iframe specifies an empty 'sandbox' attribute by default (most secure). Additional permissions can be specified per-channel using a 'sandbox' attribute on the OPML 'outline' for the channel, globally for all channels via this param, or both. -->
  <xsl:param name="www-eee-channel-sandbox" select="''" />

  <!-- The index you want the channel size selector to default to, an integer between '1' (smallest) and '5' (largest). -->
  <xsl:param name="www-eee-channel-size-default" select="2" />

  <!-- Default Theme. -->
  <xsl:param name="www-eee-default-theme-disable" select="'false'" />
  <xsl:param name="www-eee-body-background" select="'#E9EBEE'" />
  <xsl:param name="www-eee-body-color" select="'black'" />
  <xsl:param name="www-eee-chrome-border-style" select="'solid'" />
  <xsl:param name="www-eee-chrome-border-width" select="'thin'" />
  <xsl:param name="www-eee-chrome-border-color" select="'gainsboro'" />
  <xsl:param name="www-eee-chrome-background" select="'white'" />
  <xsl:param name="www-eee-chrome-color" select="'gray'" />
  <xsl:param name="www-eee-chrome-outline-color" select="'var(--www-eee-chrome-border-color)'" />
  <xsl:param name="www-eee-portal-header-border-style" select="'var(--www-eee-chrome-border-style)'" />
  <xsl:param name="www-eee-portal-header-border-width" select="'var(--www-eee-chrome-border-width)'" />
  <xsl:param name="www-eee-portal-header-border-color" select="'var(--www-eee-chrome-border-color)'" />
  <xsl:param name="www-eee-portal-header-background" select="'var(--www-eee-chrome-background)'" />
  <xsl:param name="www-eee-portal-header-color" select="'var(--www-eee-chrome-color)'" />
  <xsl:param name="www-eee-portal-header-outline-color" select="'var(--www-eee-chrome-outline-color)'" />
  <xsl:param name="www-eee-portal-title-border-style" select="'none'" />
  <xsl:param name="www-eee-portal-title-border-width" select="'0'" />
  <xsl:param name="www-eee-portal-title-border-color" select="'transparent'" />
  <xsl:param name="www-eee-portal-title-background" select="'transparent'" />
  <xsl:param name="www-eee-portal-title-color" select="'black'" />
  <xsl:param name="www-eee-portal-title-outline-color" select="'inherit'" />
  <xsl:param name="www-eee-portal-title-font-family" select="'sans-serif'" />
  <xsl:param name="www-eee-favicon-background" select="'transparent'" />
  <xsl:param name="www-eee-group-nav-border-style" select="'none'" />
  <xsl:param name="www-eee-group-nav-border-width" select="'0'" />
  <xsl:param name="www-eee-group-nav-border-color" select="'transparent'" />
  <xsl:param name="www-eee-group-nav-background" select="'transparent'" />
  <xsl:param name="www-eee-group-nav-color" select="'inherit'" />
  <xsl:param name="www-eee-group-nav-outline-color" select="'inherit'" />
  <xsl:param name="www-eee-group-nav-font-family" select="'var(--www-eee-portal-title-font-family)'" />
  <xsl:param name="www-eee-group-nav-item-unchecked-border-style" select="'var(--www-eee-chrome-border-style)'" />
  <xsl:param name="www-eee-group-nav-item-unchecked-border-width" select="'var(--www-eee-chrome-border-width)'" />
  <xsl:param name="www-eee-group-nav-item-unchecked-border-color" select="'transparent'" />
  <xsl:param name="www-eee-group-nav-item-unchecked-background" select="'transparent'" />
  <xsl:param name="www-eee-group-nav-item-unchecked-color" select="'inherit'" />
  <xsl:param name="www-eee-group-nav-item-checked-border-style" select="'var(--www-eee-chrome-border-style)'" />
  <xsl:param name="www-eee-group-nav-item-checked-border-width" select="'var(--www-eee-chrome-border-width)'" />
  <xsl:param name="www-eee-group-nav-item-checked-border-color" select="'var(--www-eee-chrome-border-color)'" />
  <xsl:param name="www-eee-group-nav-item-checked-background" select="'var(--www-eee-chrome-background)'" />
  <xsl:param name="www-eee-group-nav-item-checked-color" select="'inherit'" />
  <xsl:param name="www-eee-group-nav-item-checked-outline-color" select="'var(--www-eee-chrome-outline-color)'" />
  <xsl:param name="www-eee-channel-chrome-border-style" select="'var(--www-eee-chrome-border-style)'" />
  <xsl:param name="www-eee-channel-chrome-border-width" select="'var(--www-eee-chrome-border-width)'" />
  <xsl:param name="www-eee-channel-chrome-border-color" select="'var(--www-eee-chrome-border-color)'" />
  <xsl:param name="www-eee-channel-chrome-background" select="'var(--www-eee-chrome-background)'" />
  <xsl:param name="www-eee-channel-chrome-color" select="'var(--www-eee-chrome-color)'" />
  <xsl:param name="www-eee-channel-chrome-outline-color" select="'var(--www-eee-channel-chrome-border-color)'" />
  <xsl:param name="www-eee-channel-header-background" select="'transparent'" />
  <xsl:param name="www-eee-channel-title-color" select="'black'" />
  <xsl:param name="www-eee-channel-title-font-family" select="'var(--www-eee-portal-title-font-family)'" />
  <xsl:param name="www-eee-channel-control-border-style" select="'none'" />
  <xsl:param name="www-eee-channel-control-border-width" select="'0'" />
  <xsl:param name="www-eee-channel-control-border-color" select="'transparent'" />
  <xsl:param name="www-eee-channel-control-background" select="'transparent'" />
  <xsl:param name="www-eee-channel-control-color" select="'var(--www-eee-channel-chrome-border-color)'" />
  <xsl:param name="www-eee-channel-content-border-style" select="'var(--www-eee-channel-chrome-border-style)'" />
  <xsl:param name="www-eee-channel-content-border-width" select="'var(--www-eee-channel-chrome-border-width)'" />
  <xsl:param name="www-eee-channel-content-border-color" select="'var(--www-eee-channel-chrome-border-color)'" />
  <xsl:param name="www-eee-channel-content-background" select="'var(--www-eee-channel-chrome-background)'" />
  <xsl:param name="www-eee-channel-content-color" select="'var(--www-eee-channel-chrome-color)'" />
  <xsl:param name="www-eee-portal-footer-border-style" select="'var(--www-eee-chrome-border-style)'" />
  <xsl:param name="www-eee-portal-footer-border-width" select="'var(--www-eee-chrome-border-width)'" />
  <xsl:param name="www-eee-portal-footer-border-color" select="'var(--www-eee-chrome-border-color)'" />
  <xsl:param name="www-eee-portal-footer-background" select="'whitesmoke'" />
  <xsl:param name="www-eee-portal-footer-color" select="'var(--www-eee-chrome-color)'" />
  <xsl:param name="www-eee-portal-footer-outline-color" select="'var(--www-eee-chrome-outline-color)'" />
  <xsl:param name="www-eee-channel-size-item-checked-border-color" select="'black'" />


  <xsl:template match="@*|node()" mode="identity">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" mode="identity" />
    </xsl:copy>
  </xsl:template>


  <!-- Create a valid XML ID value from the text input. -->
  <xsl:template name="encode_id">
    <xsl:param name="text" />

    <xsl:variable name="ascii-chars">
      <xsl:text>!&quot;#$%&amp;&apos;()*+,-./0123456789:;&lt;=&gt;?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~&#127;</xsl:text>
    </xsl:variable>
    <xsl:variable name="valid-chars">
      <xsl:text>-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz</xsl:text>
    </xsl:variable>
    <xsl:variable name="hex-chars">
      <xsl:text>0123456789ABCDEFABCDEF</xsl:text>
    </xsl:variable>

    <xsl:if test="$text">
      <xsl:variable name="first-char" select="substring($text,1,1)" />
      <xsl:choose>
        <xsl:when test="contains($valid-chars, $first-char)">
          <xsl:value-of select="$first-char" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="ascii-value" select="string-length(substring-before($ascii-chars, $first-char)) + 32" />
          <xsl:text>_</xsl:text>
          <xsl:value-of select="substring($hex-chars, floor($ascii-value div 16) + 1,1)" />
          <xsl:value-of select="substring($hex-chars, $ascii-value mod 16 + 1, 1)" />
        </xsl:otherwise>
      </xsl:choose>

      <xsl:call-template name="encode_id">
        <xsl:with-param name="text" select="substring($text,2)" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template name="style_inline">
    <xsl:param name="id" select="''" />
    <xsl:param name="title" select="''" />
    <xsl:param name="style" />
    <xsl:element name="style">
      <xsl:if test="$id">
        <xsl:attribute name="id">
          <xsl:value-of select="$id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="$title">
        <xsl:attribute name="title">
          <xsl:value-of select="$title" />
        </xsl:attribute>
      </xsl:if>
      <xsl:text disable-output-escaping="yes">&#x0A;/* &lt;![CDATA[ */&#x0A;</xsl:text>
      <xsl:value-of select="$style" disable-output-escaping="yes" />
      <xsl:text>&#x0A;/* ]]</xsl:text>
      <xsl:text disable-output-escaping="yes">&gt; */&#x0A;</xsl:text>
    </xsl:element>
  </xsl:template>


  <xsl:template name="write_group_id">
    <xsl:call-template name="encode_id">
      <xsl:with-param name="text" select="@text" />
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="write_channel_id">
    <xsl:for-each select="..">
      <xsl:call-template name="write_group_id" />
    </xsl:for-each>
    <xsl:text>-</xsl:text>
    <xsl:call-template name="encode_id">
      <xsl:with-param name="text" select="@text" />
    </xsl:call-template>
  </xsl:template>


  <xsl:template name="functional_style">
    <xsl:call-template name="style_inline">
      <xsl:with-param name="id" select="'functional_style'" />
      <xsl:with-param name="style">
        <xsl:text>
<![CDATA[

html {
  display: grid;
  min-height: 100%;
}

body {
  display: grid;
  margin: 0;
  background-color: white;
  color: black;
  padding: 0;
}

div#content {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

input.group_nav_state, input.channel_size_state {
  position: absolute;
  left: -10000px;
  top: auto;
  width: 1px;
  height: 1px;
  overflow: hidden;
}

input.channel_maximize_state, input.channel_close_state {
  display: none;
}

input.channel_maximize_state:checked ~ div#content { /* Make sure content doesn't stick out below the maximized channel. */
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

:focus {
  outline-style: dotted;
  outline-width: thin;
  outline-color: black;
}

div#content > header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0;
  padding: 0;
}

div#content > header > * {
  margin: 0;
  margin-right: 0.8rem;
}

div#portal_title {
  display: flex;
  align-items: center;
}

div#portal_title > * {
  margin: 0;
  padding: 0.4rem;
}

div#portal_title > *:last-child {
  padding-left: 0.8rem;
  padding-right: 0.8rem;
}

a#favicon {
  display: grid;
  border-style: none;
  border-width: 0;
  text-decoration: none;
}

a#favicon img {
  width: 2rem;
  height: 2rem;
}

div#portal_title > h1 {
  padding-top: 0.2rem;
  padding-bottom: 0.2rem;
  white-space: nowrap;
}

div#portal_title > a#favicon + h1 {
  padding-left: 0.4rem;
}

ol#header_links {
  display: flex;
  align-items: center;
  margin: 0;
}

ol#header_links > li {
  display: grid;
  margin: 0;
  margin-left: 0.8rem;
  white-space: nowrap;
}

ol#header_links > li > a, ol#header_links > li > a:link, ol#header_links > li > a:visited {
  display: grid;
  text-decoration: none;
  color: inherit;
}

ol#header_links > li > a > img {
  width: 2rem;
  height: 2rem;
}

div#middle {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

div#middle > nav {
  display: flex;
  flex-direction: column;
  padding: 0.4rem;
  padding-bottom: 0;
}

div#middle > nav > * {
  margin: 0.4rem;
}

div#middle > nav > *:last-child {
  margin-bottom: 0;
}

div#middle > nav > ol {
  padding: 0;
  list-style-type: none;
}

div#middle > nav > ol > li {
  margin: 0;
  font-size: larger;
  white-space: nowrap;
}

div#middle > nav > ol > li > label {
  display: block;
  padding: 0.8rem;
  padding-top: 0.2rem;
  padding-bottom: 0.2rem;
  cursor: pointer;
}

div#middle > main {
  flex-grow: 1;
}

section.group {
  display: none;
  flex-direction: column;
  padding: 0.4rem;
}

section.group > h2 {
  display: none;
}

section.channel {
  display: grid;
  margin: 0;
  background-color: white;
  padding: 0;
  flex-grow: 1;
}

div.channel_chrome {
  margin: 0.4rem;
  display: flex;
  flex-direction: column;
}

div.channel_chrome > header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.8rem;
  padding-top: 0.4rem;
  padding-bottom: 0.4rem;
}

div.channel_chrome > header > h3 {
  margin: 0;
  padding: 0;
  white-space: nowrap;
  font-size: 1.5rem;
}

div.channel_chrome > header > h3 > a, div.channel_chrome > header > h3 > a:link, div.channel_chrome > header > h3 > a:visited {
  text-decoration: none;
  color: inherit;
}

div.channel_controls {
  display: flex;
  align-items: center;
}

div.channel_controls > * {
  flex-grow: 1;
  display: grid;
  margin: 0;
  margin-left: 0.8rem;
  width: 1.7rem;
  height: 1.7rem;
  padding: 0;
  cursor: pointer;
}

.channel_control_icon {
  fill: none;
  stroke: black;
}

.maximize_control_window_title {
  fill: black;
}

.channel_content {
  flex-basis: 30rem;
  flex-grow: 1;
  margin: 0.8rem;
  margin-top: 0;
  border-width: inherit;
}

div#content > footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0;
}

div#content > footer > address {
  margin: 0.4rem;
  padding: 0;
  padding-left: 0.4rem;
  padding-right: 0.4rem;
  font-style: normal;
}

div#content > footer > address a, div#content > footer > address a:link, div#content > footer > address a:visited {
  text-decoration: none;
  color: inherit;
}

ol#footer_links {
  display: flex;
  align-items: center;
  margin: 0.4rem;
  margin-top: 0.2rem;
  margin-bottom: 0.2rem;
  padding: 0;
}

ol#footer_links > li {
  display: grid;
  margin: 0;
  margin-right: 0.4rem;
  margin-left: 0.4rem;
  white-space: nowrap;
}

ol#footer_links > li > a, ol#footer_links > li > a:link, ol#footer_links > li > a:visited {
  display: grid;
  text-decoration: none;
  color: inherit;
}

ol#footer_links > li > a > img {
  width: 1.8rem;
  height: 1.8rem;
}

ol#channel_size_controls {
  display: none;
  align-items: center;
  margin: 0.4rem;
  margin-top: 0.2rem;
  margin-bottom: 0.2rem;
  padding: 0;
}

ol#channel_size_controls > li {
  display: flex;
  flex-grow: 1;
  margin: 0;
  margin-left: 0.4rem;
  margin-right: 0.4rem;
  padding: 0;
  width: 1.8rem;
  height: 1.8rem;
}

ol#channel_size_controls > li > label {
  display: flex;
  flex-grow: 1;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-style: dashed;
  border-width: medium;
  border-color: transparent;
}

ol#channel_size_controls > li > label > span {
  display: block;
  background-color: black;
  color: transparent;
}

ol#channel_size_controls > li > label > span > span {
  opacity: 0; /* Still read by screen readers.  */
}

li#channel_size_item_1 > label > span {
  width: 0.5em;
  height: 0.5em;
}

li#channel_size_item_2 > label > span {
  width: 0.7em;
  height: 0.7em;
}

li#channel_size_item_3 > label > span {
  width: 0.9em;
  height: 0.9em;
}

li#channel_size_item_4 > label > span {
  width: 1.2em;
  height: 1.2em;
}

li#channel_size_item_5 > label > span {
  width: 1.5em;
  height: 1.5em;
}

input#channel_size_state_1:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_1 > label,
input#channel_size_state_2:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_2 > label,
input#channel_size_state_3:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_3 > label,
input#channel_size_state_4:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_4 > label,
input#channel_size_state_5:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_5 > label {
  outline-style: dotted;
  outline-width: thin;
  outline-color: black;
}

input#channel_size_state_1:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_1 > label,
input#channel_size_state_2:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_2 > label,
input#channel_size_state_3:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_3 > label,
input#channel_size_state_4:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_4 > label,
input#channel_size_state_5:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_5 > label {
  border-color: inherit;
}

@media (min-width: 50rem) {

  div#middle {
    flex-direction: row;
    align-items: flex-start;
  }

  div#middle > nav {
    padding-right: 0;
    padding-bottom: 0.4rem;
  }

  div#middle > nav > * {
    margin-right: 0;
    margin-bottom: 0.4rem;
  }

  div#middle > nav > *:last-child {
    margin-bottom: 0.4rem;
  }

  section.group {
    flex-direction: row;
    align-items: flex-start;
    flex-wrap: wrap;
  }

  input#channel_size_state_1:checked ~ div#content > div#middle > main > section.group > section.channel {
    flex-basis: 15rem;
  }

  input#channel_size_state_1:checked ~ div#content > div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 30rem;
  }

  input#channel_size_state_2:checked ~ div#content > div#middle > main > section.group > section.channel {
    flex-basis: 25rem;
  }

  input#channel_size_state_2:checked ~ div#content > div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 35rem;
  }

  input#channel_size_state_3:checked ~ div#content > div#middle > main > section.group > section.channel {
    flex-basis: 35rem;
  }

  input#channel_size_state_3:checked ~ div#content > div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 40rem;
  }

  input#channel_size_state_4:checked ~ div#content > div#middle > main > section.group > section.channel {
    flex-basis: 50rem;
  }

  input#channel_size_state_4:checked ~ div#content > div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 50rem;
  }

  input#channel_size_state_5:checked ~ div#content > div#middle > main > section.group > section.channel {
    flex-basis: 70rem;
  }

  input#channel_size_state_5:checked ~ div#content > div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 70rem;
  }

  ol#channel_size_controls {
    display: flex;
  }

}

]]>
        </xsl:text>

        <xsl:for-each select="body/outline">

          <!-- Display a focus outline around the navigation tab for a group when it's nav state input is focused. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:focus ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  outline-style: dotted;&#x0A;  outline-width: thin;&#x0A;  outline-color: black;&#x0A;}&#x0A;</xsl:text>

          <!-- Highlight the navigation tab for a group when it's nav state input is checked. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:checked ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  font-weight: bold;&#x0A;}&#x0A;</xsl:text>

          <!-- Display the content section for a group when it's nav state input is checked. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:checked ~ div#content > div#middle > main > section#Group-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  display: flex;&#x0A;}&#x0A;</xsl:text>

          <!-- Display the channel state inputs for a group when it's nav state input is checked. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:checked ~ input.channel_group_state_</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  display: inline-block;&#x0A;  position: absolute;&#x0A;  left: -10000px;&#x0A;  top: auto;&#x0A;  width: 1px;&#x0A;  height: 1px;&#x0A;  overflow: hidden;&#x0A;}&#x0A;</xsl:text>

          <xsl:for-each select="outline">

            <!-- Display a focus outline around the channel maximize control when it's maximize state input is focused. -->
            <xsl:text>&#x0A;input#ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:focus ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_maximize {&#x0A;  outline-style: dotted;&#x0A;  outline-width: thin;&#x0A;  outline-color: black;&#x0A;}&#x0A;</xsl:text>

            <!-- Maximize the channel section when it's maximize state input is checked. -->
            <xsl:text>&#x0A;input#ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:checked ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> {&#x0A;  position: absolute;&#x0A;  width: 100%;&#x0A;  height: 100%;&#x0A;  top: 0;&#x0A;  left: 0;&#x0A;  flex-basis: auto;&#x0A;}&#x0A;</xsl:text>

            <!-- Don't set channel_content flex-basis when maximized, as it will be positioned to fill the screen (which will then determine it's size) and this could cause overflow. -->
            <xsl:text>&#x0A;input#ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:checked ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > .channel_content {&#x0A;  flex-basis: auto;&#x0A;}&#x0A;</xsl:text>

            <!-- Don't display the channel close control when it's maximize state input is checked. -->
            <xsl:text>&#x0A;input#ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:checked ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_close {&#x0A;  display: none;&#x0A;}&#x0A;</xsl:text>

            <!-- Display a focus outline around the channel close control when it's close state input is focused. -->
            <xsl:text>&#x0A;input#ChannelCloseState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:focus ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_close {&#x0A;  outline-style: dotted;&#x0A;  outline-width: thin;&#x0A;  outline-color: black;&#x0A;}&#x0A;</xsl:text>

            <!-- Don't display the channel when it's close state input is checked. -->
            <xsl:text>&#x0A;input#ChannelCloseState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:checked ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> {&#x0A;  display: none;&#x0A;}&#x0A;</xsl:text>

          </xsl:for-each>

        </xsl:for-each>

      </xsl:with-param>
    </xsl:call-template><!-- style_inline -->
  </xsl:template><!-- functional_style -->


  <xsl:template name="default_theme_style">
    <xsl:call-template name="style_inline">
      <xsl:with-param name="id" select="'default_theme_style'" />
      <xsl:with-param name="title">
        <xsl:choose>
          <xsl:when test="head/title">
            <xsl:value-of select="head/title" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>1</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="style">
        <xsl:text>:root {&#x0A;</xsl:text>

        <xsl:text>  --www-eee-body-background: </xsl:text>
        <xsl:value-of select="$www-eee-body-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-body-color: </xsl:text>
        <xsl:value-of select="$www-eee-body-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-background: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-color: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-chrome-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-chrome-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-background: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-header-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-header-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-background: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-title-font-family: </xsl:text>
        <xsl:value-of select="$www-eee-portal-title-font-family" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-favicon-background: </xsl:text>
        <xsl:value-of select="$www-eee-favicon-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-background: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-font-family: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-font-family" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-unchecked-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-unchecked-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-unchecked-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-unchecked-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-unchecked-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-unchecked-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-unchecked-background: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-unchecked-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-unchecked-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-unchecked-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-background: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-group-nav-item-checked-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-group-nav-item-checked-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-background: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-chrome-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-chrome-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-header-background: </xsl:text>
        <xsl:value-of select="$www-eee-channel-header-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-title-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-title-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-title-font-family: </xsl:text>
        <xsl:value-of select="$www-eee-channel-title-font-family" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-control-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-channel-control-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-control-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-channel-control-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-control-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-control-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-control-background: </xsl:text>
        <xsl:value-of select="$www-eee-channel-control-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-control-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-control-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-content-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-channel-content-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-content-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-channel-content-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-content-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-content-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-content-background: </xsl:text>
        <xsl:value-of select="$www-eee-channel-content-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-content-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-content-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-border-style: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-border-style" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-border-width: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-border-width" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-background: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-background" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-portal-footer-outline-color: </xsl:text>
        <xsl:value-of select="$www-eee-portal-footer-outline-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>  --www-eee-channel-size-item-checked-border-color: </xsl:text>
        <xsl:value-of select="$www-eee-channel-size-item-checked-border-color" />
        <xsl:text>;&#x0A;</xsl:text>

        <xsl:text>}&#x0A;</xsl:text>

        <xsl:text>
<![CDATA[

body {
  background-color: var(--www-eee-body-background);
  color: var(--www-eee-body-color);
}

div#content > header {
  border-style: var(--www-eee-portal-header-border-style);
  border-width: var(--www-eee-portal-header-border-width);
  border-color: var(--www-eee-portal-header-border-color);
  background-color: var(--www-eee-portal-header-background);
  color: var(--www-eee-portal-header-color);
  border-top: none;
  border-right: none;
  border-left: none;
}

div#content > header :focus {
  outline-color: var(--www-eee-portal-header-outline-color);
}

div#portal_title {
  border-style: var(--www-eee-portal-title-border-style);
  border-width: var(--www-eee-portal-title-border-width);
  border-color: var(--www-eee-portal-title-border-color);
  background-color: var(--www-eee-portal-title-background);
  color: var(--www-eee-portal-title-color);
  font-family: var(--www-eee-portal-title-font-family);
}

a#favicon {
  background-color: var(--www-eee-favicon-background);
}

div#portal_title :focus {
  outline-color: var(--www-eee-portal-title-outline-color);
}

div#middle > nav {
  border-style: var(--www-eee-group-nav-border-style);
  border-width: var(--www-eee-group-nav-border-width);
  border-color: var(--www-eee-group-nav-border-color);
  border-left: none;
  background-color: var(--www-eee-group-nav-background);
  color: var(--www-eee-group-nav-color);
  font-family: var(--www-eee-group-nav-font-family);
}

div#middle > nav :focus {
  outline-color: var(--www-eee-group-nav-outline-color);
}

div#middle > nav > ol > li {
  border-style: var(--www-eee-group-nav-item-unchecked-border-style);
  border-width: var(--www-eee-group-nav-item-unchecked-border-width);
  border-color: var(--www-eee-group-nav-item-unchecked-border-color);
  background-color: var(--www-eee-group-nav-item-unchecked-background);
  color: var(--www-eee-group-nav-item-unchecked-color);
}

section.channel {
  background-color: var(--www-eee-body-background);
}

div.channel_chrome {
  background-color: var(--www-eee-channel-chrome-background);
  color: var(--www-eee-channel-chrome-color);
  border-style: var(--www-eee-channel-chrome-border-style);
  border-width: var(--www-eee-channel-chrome-border-width);
  border-color: var(--www-eee-channel-chrome-border-color);
}

div.channel_chrome :focus {
  outline-color: var(--www-eee-channel-chrome-outline-color);
}

div.channel_chrome > header {
  background-color: var(--www-eee-channel-header-background);
}

div.channel_chrome > header > h3 {
  color: var(--www-eee-channel-title-color);
  font-family: var(--www-eee-channel-title-font-family);
}

.channel_control_icon {
  stroke: var(--www-eee-channel-control-color);
}

.maximize_control_window_title {
  fill: var(--www-eee-channel-control-color);
}

div.channel_controls > * {
  border-style: var(--www-eee-channel-control-border-style);
  border-width: var(--www-eee-channel-control-border-width);
  border-color: var(--www-eee-channel-control-border-color);
  background-color: var(--www-eee-channel-control-background);
  color: var(--www-eee-channel-control-color);
}

.channel_content {
  border-style: var(--www-eee-channel-content-border-style);
  border-width: var(--www-eee-channel-content-border-width);
  border-color: var(--www-eee-channel-content-border-color);
  border-right-style: none;
  border-bottom-style: none;
  border-left-style: none;
  background-color: var(--www-eee-channel-content-background);
  color: var(--www-eee-channel-content-color);
}

div#content > footer {
  border-style: var(--www-eee-portal-footer-border-style);
  border-width: var(--www-eee-portal-footer-border-width);
  border-color: var(--www-eee-portal-footer-border-color);
  background-color: var(--www-eee-portal-footer-background);
  color: var(--www-eee-portal-footer-color);
  border-right: none;
  border-bottom: none;
  border-left: none;
}

div#content > footer :focus {
  outline-color: var(--www-eee-portal-footer-outline-color);
}

ol#channel_size_controls > li > label > span {
  background-color: var(--www-eee-portal-footer-color);
}

input#channel_size_state_1:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_1 > label,
input#channel_size_state_2:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_2 > label,
input#channel_size_state_3:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_3 > label,
input#channel_size_state_4:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_4 > label,
input#channel_size_state_5:focus ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_5 > label {
  outline-color: var(--www-eee-portal-footer-outline-color);
}

input#channel_size_state_1:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_1 > label,
input#channel_size_state_2:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_2 > label,
input#channel_size_state_3:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_3 > label,
input#channel_size_state_4:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_4 > label,
input#channel_size_state_5:checked ~ div#content > footer > ol#channel_size_controls > li#channel_size_item_5 > label {
  border-color: var(--www-eee-channel-size-item-checked-border-color);
}

]]>
        </xsl:text>

        <xsl:for-each select="body/outline">

          <!-- Display a focus outline around the navigation tab for a group when it's nav state input is focused. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:focus ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  outline-color: var(--www-eee-group-nav-item-checked-outline-color);&#x0A;}&#x0A;</xsl:text>

          <!-- Highlight the navigation tab for a group when it's nav state input is checked. -->
          <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text>:checked ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
          <xsl:call-template name="write_group_id" />
          <xsl:text> {&#x0A;  border-style: var(--www-eee-group-nav-item-checked-border-style);&#x0A;  border-width: var(--www-eee-group-nav-item-checked-border-width);&#x0A;  border-color: var(--www-eee-group-nav-item-checked-border-color);&#x0A;  background-color: var(--www-eee-group-nav-item-checked-background);&#x0A;  color: var(--www-eee-group-nav-item-checked-color);&#x0A;}&#x0A;</xsl:text>

          <xsl:for-each select="outline">

            <!-- Display a focus outline around the channel maximize control when it's maximize state input is focused. -->
            <xsl:text>&#x0A;input#ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:focus ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_maximize {&#x0A;  outline-color: var(--www-eee-channel-chrome-outline-color);&#x0A;}&#x0A;</xsl:text>

            <!-- Display a focus outline around the channel close control when it's close state input is focused. -->
            <xsl:text>&#x0A;input#ChannelCloseState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text>:focus ~ div#content > div#middle > main > section.group > section#Channel-</xsl:text>
            <xsl:call-template name="write_channel_id" />
            <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_close {&#x0A;  outline-color: var(--www-eee-channel-chrome-outline-color);&#x0A;}&#x0A;</xsl:text>

          </xsl:for-each>

        </xsl:for-each>

      </xsl:with-param>
    </xsl:call-template><!-- style_inline -->
  </xsl:template><!-- default_theme_style -->


  <xsl:template name="custom_style">
    <xsl:if test="$www-eee-includes-document">

      <xsl:variable name="includes_document_content" select="document($www-eee-includes-document)" />
      <xsl:variable name="portal_title" select="head/title" />
      <xsl:variable name="group_outlines" select="body/outline" />

      <xsl:for-each select="$includes_document_content//html:html/html:style[@class='custom_style']">
        <xsl:call-template name="style_inline">
          <xsl:with-param name="id">
            <xsl:text>custom_style_</xsl:text>
            <xsl:value-of select="position()" />
          </xsl:with-param>
          <xsl:with-param name="title">
            <xsl:choose>
              <xsl:when test="@title">
                <xsl:value-of select="@title" />
              </xsl:when>
              <xsl:when test="$portal_title">
                <xsl:value-of select="$portal_title" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="style">
            <xsl:apply-templates select="node()" mode="identity" />
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="$includes_document_content//html:html/html:style[@class='custom_style_group_nav_item_focus']">
        <xsl:variable name="style_content" select="node()" />
        <xsl:call-template name="style_inline">
          <xsl:with-param name="id">
            <xsl:text>custom_style_group_nav_item_focus_</xsl:text>
            <xsl:value-of select="position()" />
          </xsl:with-param>
          <xsl:with-param name="title">
            <xsl:choose>
              <xsl:when test="@title">
                <xsl:value-of select="@title" />
              </xsl:when>
              <xsl:when test="$portal_title">
                <xsl:value-of select="$portal_title" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="style">
            <xsl:for-each select="$group_outlines">
              <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text>:focus ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text> {&#x0A;</xsl:text>
              <xsl:apply-templates select="$style_content" mode="identity" />
              <xsl:text>}&#x0A;</xsl:text>
            </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="$includes_document_content//html:html/html:style[@class='custom_style_group_nav_label_focus']">
        <xsl:variable name="style_content" select="node()" />
        <xsl:call-template name="style_inline">
          <xsl:with-param name="id">
            <xsl:text>custom_style_group_nav_label_focus_</xsl:text>
            <xsl:value-of select="position()" />
          </xsl:with-param>
          <xsl:with-param name="title">
            <xsl:choose>
              <xsl:when test="@title">
                <xsl:value-of select="@title" />
              </xsl:when>
              <xsl:when test="$portal_title">
                <xsl:value-of select="$portal_title" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="style">
            <xsl:for-each select="$group_outlines">
              <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text>:focus ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text> > label {&#x0A;</xsl:text>
              <xsl:apply-templates select="$style_content" mode="identity" />
              <xsl:text>}&#x0A;</xsl:text>
            </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="$includes_document_content//html:html/html:style[@class='custom_style_group_nav_item_checked']">
        <xsl:variable name="style_content" select="node()" />
        <xsl:call-template name="style_inline">
          <xsl:with-param name="id">
            <xsl:text>custom_style_group_nav_item_checked_</xsl:text>
            <xsl:value-of select="position()" />
          </xsl:with-param>
          <xsl:with-param name="title">
            <xsl:choose>
              <xsl:when test="@title">
                <xsl:value-of select="@title" />
              </xsl:when>
              <xsl:when test="$portal_title">
                <xsl:value-of select="$portal_title" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="style">
            <xsl:for-each select="$group_outlines">
              <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text>:checked ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text> {&#x0A;</xsl:text>
              <xsl:apply-templates select="$style_content" mode="identity" />
              <xsl:text>}&#x0A;</xsl:text>
            </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="$includes_document_content//html:html/html:style[@class='custom_style_group_nav_label_checked']">
        <xsl:variable name="style_content" select="node()" />
        <xsl:call-template name="style_inline">
          <xsl:with-param name="id">
            <xsl:text>custom_style_group_nav_label_checked_</xsl:text>
            <xsl:value-of select="position()" />
          </xsl:with-param>
          <xsl:with-param name="title">
            <xsl:choose>
              <xsl:when test="@title">
                <xsl:value-of select="@title" />
              </xsl:when>
              <xsl:when test="$portal_title">
                <xsl:value-of select="$portal_title" />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="position()" />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:with-param>
          <xsl:with-param name="style">
            <xsl:for-each select="$group_outlines">
              <xsl:text>&#x0A;input#GroupNavState-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text>:checked ~ div#content > div#middle > nav > ol > li#GroupNavItem-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text> > label {&#x0A;</xsl:text>
              <xsl:apply-templates select="$style_content" mode="identity" />
              <xsl:text>}&#x0A;</xsl:text>
            </xsl:for-each>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>

    </xsl:if><!-- $www-eee-includes-document -->
  </xsl:template><!-- custom_style -->


  <xsl:template name="head">
    <xsl:element name="head">

      <xsl:if test="head/title">
        <xsl:element name="title">
          <xsl:value-of select="head/title" />
        </xsl:element>
      </xsl:if>

      <xsl:if test="$www-eee-favicon-disable = 'false'">
        <xsl:element name="link">
          <xsl:attribute name="rel">
            <xsl:text>icon</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="type">
            <xsl:text>image/svg+xml</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="href">
            <xsl:text>favicon.svg</xsl:text>
          </xsl:attribute>
        </xsl:element>
      </xsl:if>

      <xsl:element name="meta">
        <xsl:attribute name="name">
          <xsl:text>viewport</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="content">
          <xsl:text>width=device-width, initial-scale=1</xsl:text>
        </xsl:attribute>
      </xsl:element>

      <xsl:call-template name="functional_style" />
      <xsl:if test="$www-eee-default-theme-disable = 'false'">
        <xsl:call-template name="default_theme_style" />
      </xsl:if>
      <xsl:call-template name="custom_style" />

    </xsl:element><!-- head -->
  </xsl:template><!-- head -->


  <xsl:template name="group_nav_state">
    <xsl:for-each select="body/outline">

      <xsl:element name="input">
        <xsl:attribute name="type">
          <xsl:text>radio</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="name">
          <xsl:text>group_nav_state</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="class">
          <xsl:text>state group_nav_state</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="id">
          <xsl:text>GroupNavState-</xsl:text>
          <xsl:call-template name="write_group_id" />
        </xsl:attribute>
        <xsl:attribute name="tabindex">
          <xsl:text>30000</xsl:text>
        </xsl:attribute>
        <xsl:if test="position() = 1"><!-- Open the first group page by default. -->
          <xsl:attribute name="checked">
            <xsl:text>checked</xsl:text>
          </xsl:attribute>
        </xsl:if>
      </xsl:element>

    </xsl:for-each><!-- group outline -->
  </xsl:template><!-- group_nav_state -->


  <xsl:template name="channel_control_state">
    <xsl:for-each select="body/outline">

      <xsl:for-each select="outline">

        <xsl:element name="input">
          <xsl:attribute name="type">
            <xsl:text>checkbox</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>state channel_control_state channel_maximize_state channel_group_state_</xsl:text>
            <xsl:for-each select="..">
              <xsl:call-template name="write_group_id" />
            </xsl:for-each>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>ChannelMaximizeState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
          </xsl:attribute>
          <xsl:attribute name="tabindex">
            <xsl:value-of select="(position() * 10) + 40001" />
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="input">
          <xsl:attribute name="type">
            <xsl:text>checkbox</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>state channel_control_state channel_close_state channel_group_state_</xsl:text>
            <xsl:for-each select="..">
              <xsl:call-template name="write_group_id" />
            </xsl:for-each>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>ChannelCloseState-</xsl:text>
            <xsl:call-template name="write_channel_id" />
          </xsl:attribute>
          <xsl:attribute name="tabindex">
            <xsl:value-of select="(position() * 10) + 40001" />
          </xsl:attribute>
        </xsl:element>

      </xsl:for-each><!-- channel outline -->

    </xsl:for-each><!-- group outline -->
  </xsl:template><!-- channel_control_state -->


  <xsl:template name="channel_size_state">
    <xsl:param name="i" select="1" />
    <xsl:param name="count" select="5" />

    <xsl:element name="input">
      <xsl:attribute name="type">
        <xsl:text>radio</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:text>channel_size_state</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>state channel_size_state</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:text>channel_size_state_</xsl:text>
        <xsl:value-of select="$i" />
      </xsl:attribute>
      <xsl:attribute name="tabindex">
        <xsl:text>70000</xsl:text>
      </xsl:attribute>
      <xsl:if test="$i = $www-eee-channel-size-default">
        <xsl:attribute name="checked">
          <xsl:text>checked</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>

    <xsl:if test="$i &lt; $count">
      <xsl:call-template name="channel_size_state">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1" />
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template><!-- channel_size_state -->


  <xsl:template name="favicon">
    <xsl:if test="$www-eee-favicon-disable = 'false'">
      <xsl:element name="a">
        <xsl:attribute name="id">
          <xsl:text>favicon</xsl:text>
        </xsl:attribute>
        <xsl:if test="head/ownerId">
          <xsl:attribute name="href">
            <xsl:value-of select="head/ownerId" />
          </xsl:attribute>
          <xsl:attribute name="target">
            <xsl:text>_blank</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="tabindex">
            <xsl:text>10000</xsl:text>
          </xsl:attribute>
        </xsl:if>

        <xsl:element name="img">
          <xsl:attribute name="src">
            <xsl:text>favicon.svg</xsl:text>
          </xsl:attribute>
          <xsl:if test="head/ownerName">
            <xsl:attribute name="alt">
              <xsl:value-of select="head/ownerName" />
            </xsl:attribute>
          </xsl:if>
        </xsl:element>
      </xsl:element>
    </xsl:if>
  </xsl:template><!-- favicon -->


  <xsl:template name="portal_title">
    <xsl:if test="head/title">
      <xsl:element name="div">
        <xsl:attribute name="id">
          <xsl:text>portal_title</xsl:text>
        </xsl:attribute>

        <xsl:call-template name="favicon" />

        <xsl:element name="h1">
          <xsl:value-of select="head/title" />
        </xsl:element>

      </xsl:element><!-- div#portal_title -->
    </xsl:if>
  </xsl:template><!-- portal_title -->


  <xsl:template name="portal_header">
    <xsl:element name="header">

      <xsl:call-template name="portal_title" />

      <xsl:if test="$www-eee-includes-document">
        <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:ol[@id='header_links']" mode="identity" />
      </xsl:if>

    </xsl:element>
  </xsl:template><!-- portal_header -->


  <xsl:template name="group_nav">
    <xsl:element name="nav">
      <xsl:element name="ol">

        <xsl:for-each select="body/outline">

          <xsl:element name="li">
            <xsl:attribute name="id">
              <xsl:text>GroupNavItem-</xsl:text>
              <xsl:call-template name="write_group_id" />
            </xsl:attribute>

            <xsl:element name="label">
              <xsl:attribute name="for">
                <xsl:text>GroupNavState-</xsl:text>
                <xsl:call-template name="write_group_id" />
              </xsl:attribute>

              <xsl:choose>
                <xsl:when test="@title">
                  <xsl:value-of select="@title" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@text" />
                </xsl:otherwise>
              </xsl:choose>

            </xsl:element><!-- label -->

          </xsl:element><!-- li -->

        </xsl:for-each><!-- group outline -->

      </xsl:element><!-- ol -->
    </xsl:element><!-- nav -->
  </xsl:template><!-- group_nav -->


  <xsl:template name="maximize_control_icon">
    <xsl:param name="title" />
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-1 -1 13 13" preserveAspectRatio="xMidYMid">

      <xsl:element name="title">
        <xsl:text>&#x1F5D6; </xsl:text><!-- 'MAXIMIZE' -->
        <xsl:value-of select="$title" />
      </xsl:element>

      <xsl:element name="g">
        <xsl:attribute name="class">
          <xsl:text>channel_control_icon maximize_control</xsl:text>
        </xsl:attribute>

        <xsl:element name="rect">
          <xsl:attribute name="class">
            <xsl:text>maximize_control_window_border</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="width">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="height">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="rect">
          <xsl:attribute name="class">
            <xsl:text>maximize_control_window_title</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="width">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="height">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
        </xsl:element>

      </xsl:element><!-- g -->

    </svg>
  </xsl:template><!-- maximize_control_icon -->


  <xsl:template name="maximize_control">
    <xsl:element name="label">
      <xsl:attribute name="class">
        <xsl:text>channel_maximize</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="for">
        <xsl:text>ChannelMaximizeState-</xsl:text>
        <xsl:call-template name="write_channel_id" />
      </xsl:attribute>
      <xsl:call-template name="maximize_control_icon">
        <xsl:with-param name="title">
          <xsl:choose>
            <xsl:when test="@title">
              <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@text" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:element>
  </xsl:template><!-- "maximize_control" -->


  <xsl:template name="close_control_icon">
    <xsl:param name="title" />
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-1 -1 13 13" preserveAspectRatio="xMidYMid">

      <xsl:element name="title">
        <xsl:text>&#x274C; </xsl:text><!-- 'CROSS MARK' -->
        <xsl:value-of select="$title" />
      </xsl:element>

      <xsl:element name="g">
        <xsl:attribute name="class">
          <xsl:text>channel_control_icon close_control</xsl:text>
        </xsl:attribute>

        <xsl:element name="line">
          <xsl:attribute name="class">
            <xsl:text>close_control_back_slash</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x1">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y1">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x2">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y2">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="line">
          <xsl:attribute name="class">
            <xsl:text>close_control_forward_slash</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x1">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y1">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x2">
            <xsl:text>11</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y2">
            <xsl:text>0</xsl:text>
          </xsl:attribute>
        </xsl:element>

      </xsl:element><!-- g -->

    </svg>
  </xsl:template><!-- close_control_icon -->


  <xsl:template name="close_control">
    <xsl:element name="label">
      <xsl:attribute name="class">
        <xsl:text>channel_close</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="for">
        <xsl:text>ChannelCloseState-</xsl:text>
        <xsl:call-template name="write_channel_id" />
      </xsl:attribute>
      <xsl:call-template name="close_control_icon">
        <xsl:with-param name="title">
          <xsl:choose>
            <xsl:when test="@title">
              <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@text" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:element>
  </xsl:template><!-- close_control -->


  <xsl:template name="channel_controls">
    <xsl:element name="div">
      <xsl:attribute name="class">
        <xsl:text>channel_controls</xsl:text>
      </xsl:attribute>
      <xsl:call-template name="maximize_control" />
      <xsl:call-template name="close_control" />
    </xsl:element>
  </xsl:template><!-- channel_controls -->


  <xsl:template name="channel_header">
    <xsl:element name="header">

      <xsl:element name="h3">
        <xsl:element name="a">
          <xsl:if test="($www-eee-channel-title-link-disable = 'false') and (@url or @htmlUrl)">
            <xsl:attribute name="href">
              <xsl:choose>
                <xsl:when test="@url">
                  <xsl:value-of select="@url" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="@htmlUrl" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="target">
              <xsl:text>_blank</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="tabindex">
              <xsl:value-of select="(position() * 10) + 40000" />
            </xsl:attribute>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="@title">
              <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@text" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:element>

      <xsl:call-template name="channel_controls" />

    </xsl:element><!-- header -->
  </xsl:template><!-- channel_header -->


  <xsl:template name="channel_content">
    <xsl:element name="iframe">
      <xsl:if test="@url or @htmlUrl">
        <xsl:attribute name="class">
          <xsl:text>channel_content</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="src">
          <xsl:choose>
            <xsl:when test="@url">
              <xsl:value-of select="@url" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@htmlUrl" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="sandbox">
          <xsl:if test="$www-eee-channel-sandbox">
            <xsl:value-of select="$www-eee-channel-sandbox" />
          </xsl:if>
          <xsl:if test="@sandbox">
            <xsl:if test="$www-eee-channel-sandbox">
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="@sandbox" />
          </xsl:if>
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:choose>
            <xsl:when test="@title">
              <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@text" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="tabindex">
          <xsl:value-of select="(position() * 10) + 40002" />
        </xsl:attribute>
      </xsl:if>
    </xsl:element><!-- iframe.channel_content -->
  </xsl:template>


  <xsl:template name="channel">
    <xsl:element name="section">
      <xsl:attribute name="id">
        <xsl:text>Channel-</xsl:text>
        <xsl:call-template name="write_channel_id" />
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>channel</xsl:text>
        <xsl:if test="@type">
          <xsl:text> channel_type_</xsl:text>
          <xsl:call-template name="encode_id">
            <xsl:with-param name="text" select="@type" />
          </xsl:call-template>
        </xsl:if>
      </xsl:attribute>

      <xsl:element name="div">
        <xsl:attribute name="class">
          <xsl:text>channel_chrome</xsl:text>
        </xsl:attribute>

        <xsl:call-template name="channel_header" />
        <xsl:call-template name="channel_content" />

      </xsl:element><!-- div.channel_chrome -->

    </xsl:element><!-- section.channel -->
  </xsl:template><!-- channel -->


  <xsl:template name="channel_size_controls">
    <xsl:param name="i" select="1" />
    <xsl:param name="count" select="5" />

    <xsl:element name="li">
      <xsl:attribute name="id">
        <xsl:text>channel_size_item_</xsl:text>
        <xsl:value-of select="$i" />
      </xsl:attribute>
      <xsl:element name="label">
        <xsl:attribute name="for">
          <xsl:text>channel_size_state_</xsl:text>
          <xsl:value-of select="$i" />
        </xsl:attribute>
        <xsl:element name="span">
          <xsl:element name="span">
            <xsl:choose>
              <xsl:when test="$i = 1">
                <xsl:text>&#x25AA;</xsl:text><!-- 'BLACK SMALL SQUARE' -->
              </xsl:when>
              <xsl:when test="$i = 2">
                <xsl:text>&#x25FE;</xsl:text><!-- 'BLACK MEDIUM SMALL SQUARE' -->
              </xsl:when>
              <xsl:when test="$i = 3">
                <xsl:text>&#x25A0;</xsl:text><!-- 'BLACK SQUARE' -->
              </xsl:when>
              <xsl:when test="$i = 4">
                <xsl:text>&#x25FC;</xsl:text><!-- 'BLACK MEDIUM SQUARE' -->
              </xsl:when>
              <xsl:when test="$i = 5">
                <xsl:text>&#x2B1B;</xsl:text><!-- 'BLACK LARGE SQUARE' -->
              </xsl:when>
            </xsl:choose>
          </xsl:element>
        </xsl:element>
      </xsl:element>
    </xsl:element>

    <xsl:if test="$i &lt; $count">
      <xsl:call-template name="channel_size_controls">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1" />
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template><!-- channel_size_controls -->


  <xsl:template name="footer_address">
    <xsl:if test="head/ownerName or head/ownerEmail">
      <xsl:element name="address">

        <xsl:if test="head/ownerName">
          <xsl:element name="a">
            <xsl:attribute name="id">
              <xsl:text>owner_name</xsl:text>
            </xsl:attribute>
            <xsl:if test="head/ownerId">
              <xsl:attribute name="href">
                <xsl:value-of select="head/ownerId" />
              </xsl:attribute>
              <xsl:attribute name="target">
                <xsl:text>_blank</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="tabindex">
                <xsl:text>50000</xsl:text>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="head/ownerName" />
          </xsl:element>
        </xsl:if>

        <xsl:if test="head/ownerEmail">
          <xsl:if test="head/ownerName">
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:element name="span">
            <xsl:attribute name="id">
              <xsl:text>owner_email</xsl:text>
            </xsl:attribute>
            <xsl:text>&lt;</xsl:text>
            <xsl:element name="a">
              <xsl:attribute name="href">
                <xsl:text>mailto:</xsl:text>
                <xsl:value-of select="head/ownerEmail" />
              </xsl:attribute>
              <xsl:attribute name="tabindex">
                <xsl:text>50000</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="head/ownerEmail" />
            </xsl:element>
            <xsl:text>&gt;</xsl:text>
          </xsl:element>
        </xsl:if>

      </xsl:element><!-- address -->
    </xsl:if><!-- owner info -->
  </xsl:template><!-- footer_address -->


  <xsl:template name="portal_footer">
    <xsl:element name="footer">

      <xsl:call-template name="footer_address" />

      <xsl:if test="$www-eee-includes-document">
        <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:ol[@id='footer_links']" mode="identity" />
      </xsl:if>

      <xsl:element name="ol">
        <xsl:attribute name="id">
          <xsl:text>channel_size_controls</xsl:text>
        </xsl:attribute>
        <xsl:call-template name="channel_size_controls" />
      </xsl:element>

    </xsl:element><!-- footer -->
  </xsl:template><!-- portal_footer -->


  <xsl:template match="opml">
    <xsl:element name="html">

      <xsl:call-template name="head" />

      <xsl:element name="body">

        <!-- Thanks to Art Lawry and Chris Coyier for pioneering this style of "Radio-Controlled Web Design". -->
        <xsl:call-template name="group_nav_state" />
        <xsl:call-template name="channel_control_state" />
        <xsl:call-template name="channel_size_state" />

        <xsl:element name="div">
          <xsl:attribute name="id">
            <xsl:text>content</xsl:text>
          </xsl:attribute>

          <xsl:call-template name="portal_header" />

          <xsl:element name="div">
            <xsl:attribute name="id">
              <xsl:text>middle</xsl:text>
            </xsl:attribute>

            <xsl:call-template name="group_nav" />

            <xsl:element name="main">

              <xsl:for-each select="body/outline">
                <xsl:element name="section">
                  <xsl:attribute name="id">
                    <xsl:text>Group-</xsl:text>
                    <xsl:call-template name="write_group_id" />
                  </xsl:attribute>
                  <xsl:attribute name="class">
                    <xsl:text>group</xsl:text>
                  </xsl:attribute>

                  <xsl:element name="h2">
                    <xsl:choose>
                      <xsl:when test="@title">
                        <xsl:value-of select="@title" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="@text" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:element>

                  <xsl:for-each select="outline">

                    <xsl:call-template name="channel" />

                  </xsl:for-each><!-- channel outline -->

                </xsl:element><!-- section.group -->
              </xsl:for-each><!-- group outline -->

            </xsl:element><!-- main -->

          </xsl:element><!-- div#main -->

          <xsl:call-template name="portal_footer" />

        </xsl:element><!-- div#content -->

      </xsl:element><!-- body -->

    </xsl:element><!-- html -->

  </xsl:template><!-- opml -->


</xsl:stylesheet>
