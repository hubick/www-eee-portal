<?xml version="1.0" encoding="utf-8"?>
<!-- Copyright 2017-2018 by Chris Hubick <chris@hubick.com>. All Rights Reserved. This work is licensed under the terms of the "GNU AFFERO GENERAL PUBLIC LICENSE" version 3, as published by the Free Software Foundation <http://www.gnu.org/licenses/>. -->
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:html="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" media-type="application/xhtml+xml" method="xml" omit-xml-declaration="no" doctype-system="about:legacy-compat" />

  <!-- If an includes document is specified it will be parsed for content to be included in the appropriate sections. -->
  <!-- Current includes are "//html:html/html:style[@id='custom_style']", "//html:html/html:style[@id='custom_style_active_group']", "//html:html/html:ol[@id='header_links']", "//html:html/html:ol[@id='footer_links']". -->
  <xsl:param name="www-eee-includes-document" />

  <!-- Should the channel titles not be made into links to the channel content URL's? -->
  <xsl:param name="www-eee-channel-title-link-disable" select="'false'" />

  <!-- The channel content iframe specifies an empty 'sandbox' attribute by default (most secure), any additional permissions can be specified here. -->
  <xsl:param name="www-eee-channel-sandbox" select="''" />

  <!-- The index you want the channel size selector to default to, an integer between '1' (smallest) and '5' (largest). -->
  <xsl:param name="www-eee-channel-size-default" select="2" />

  <!-- Default Theme. -->
  <xsl:param name="www-eee-default-theme-disable" select="'false'" />
  <xsl:param name="www-eee-body-background" select="'white'" />
  <xsl:param name="www-eee-body-foreground" select="'black'" />
  <xsl:param name="www-eee-raised-background" select="'gainsboro'" />
  <xsl:param name="www-eee-raised-foreground" select="'black'" />
  <xsl:param name="www-eee-border-color" select="'silver'" />
  <xsl:param name="www-eee-content-background" select="'var(--www-eee-body-background)'" />
  <xsl:param name="www-eee-content-foreground" select="'var(--www-eee-body-foreground)'" />
  <xsl:param name="www-eee-portal-heading-background" select="'var(--www-eee-content-background)'" />
  <xsl:param name="www-eee-portal-heading-foreground" select="'var(--www-eee-content-foreground)'" />
  <xsl:param name="www-eee-header-foreground" select="'gray'" />
  <xsl:param name="www-eee-nav-active-foreground" select="'var(--www-eee-body-foreground)'" />
  <xsl:param name="www-eee-nav-inactive-foreground" select="'var(--www-eee-raised-foreground)'" />
  <xsl:param name="www-eee-channel-title-foreground" select="'var(--www-eee-raised-foreground)'" />
  <xsl:param name="www-eee-channel-control" select="'var(--www-eee-raised-foreground)'" />
  <xsl:param name="www-eee-footer-foreground" select="'gray'" />

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

  <xsl:template name="maximize_icon">
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-1 -1 13 13" preserveAspectRatio="xMidYMid">
      <xsl:element name="g">
        <xsl:attribute name="class">
          <xsl:text>channel_control_icon maximize_icon</xsl:text>
        </xsl:attribute>

        <xsl:element name="polyline">
          <xsl:attribute name="class">
            <xsl:text>maximize_icon_minimized_box</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="points">
            <xsl:text>3,5 0,5 0,11, 6,11 6,8</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="polyline">
          <xsl:attribute name="class">
            <xsl:text>maximize_icon_maximized_box</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="points">
            <xsl:text>3,6 3,0 11,0 11,8 5,8</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="line">
          <xsl:attribute name="class">
            <xsl:text>maximize_icon_top_arrow_body</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x1">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y1">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x2">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y2">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="polyline">
          <xsl:attribute name="class">
            <xsl:text>maximize_icon_top_arrow_head</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="points">
            <xsl:text>6,2 9,2 9,5</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="polyline">
          <xsl:attribute name="class">
            <xsl:text>maximize_icon_bottom_arrow_head</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="points">
            <xsl:text>2,6 2,9 5,9</xsl:text>
          </xsl:attribute>
        </xsl:element>

      </xsl:element><!-- g -->
    </svg>
  </xsl:template><!-- maximize_icon -->

  <xsl:template name="close_icon">
    <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="-1 -1 13 13" preserveAspectRatio="xMidYMid">
      <xsl:element name="g">
        <xsl:attribute name="class">
          <xsl:text>channel_control_icon close_icon</xsl:text>
        </xsl:attribute>

        <xsl:element name="rect">
          <xsl:attribute name="class">
            <xsl:text>close_icon_box</xsl:text>
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

        <xsl:element name="line">
          <xsl:attribute name="class">
            <xsl:text>close_icon_back_slash</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x1">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y1">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x2">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y2">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:element name="line">
          <xsl:attribute name="class">
            <xsl:text>close_icon_forward_slash</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x1">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y1">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="x2">
            <xsl:text>9</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="y2">
            <xsl:text>2</xsl:text>
          </xsl:attribute>
        </xsl:element>

      </xsl:element><!-- g -->
    </svg>
  </xsl:template><!-- close_icon -->

  <xsl:template name="channel_size_input">
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
        <xsl:text>ChannelSizeRadio-</xsl:text>
        <xsl:value-of select="$i" />
      </xsl:attribute>
      <xsl:if test="$i = $www-eee-channel-size-default">
        <xsl:attribute name="checked">
          <xsl:text>checked</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>

    <xsl:if test="$i &lt; $count">
      <xsl:call-template name="channel_size_input">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1" />
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template><!-- channel_size_input -->

  <xsl:template name="channel_size_label">
    <xsl:param name="i" select="1" />
    <xsl:param name="count" select="5" />

    <xsl:element name="li">
      <xsl:attribute name="id">
        <xsl:text>ChannelSizeItem_</xsl:text>
        <xsl:value-of select="$i" />
      </xsl:attribute>
      <xsl:element name="label">
        <xsl:attribute name="for">
          <xsl:text>ChannelSizeRadio-</xsl:text>
          <xsl:value-of select="$i" />
        </xsl:attribute>
        <xsl:element name="span">
        </xsl:element>
      </xsl:element>
    </xsl:element>

    <xsl:if test="$i &lt; $count">
      <xsl:call-template name="channel_size_label">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1" />
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>

  </xsl:template><!-- channel_size_label -->

  <xsl:template match="opml">
    <xsl:element name="html">

      <xsl:element name="head">

        <xsl:if test="head/title">
          <xsl:element name="title">
            <xsl:value-of select="head/title" />
          </xsl:element>
        </xsl:if>

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

        <xsl:element name="meta">
          <xsl:attribute name="name">
            <xsl:text>viewport</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="content">
            <xsl:text>width=device-width, initial-scale=1</xsl:text>
          </xsl:attribute>
        </xsl:element>

        <xsl:call-template name="style_inline">
          <xsl:with-param name="id" select="'functional_style'" />
          <xsl:with-param name="style">
            <xsl:text>
<![CDATA[

html {
  display: flex;
  flex-direction: column;
  min-height: 100%;
}

body {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  margin: 0;
  background-color: white;
  color: black;
  padding: 0;
}

input.state {
  display: none;
}

input.channel_maximize_state:checked ~ div#middle > main { /* Make sure 'main' doesn't stick out below the maximized channel. */
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

body > header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0;
  padding: 0;
}

body > header > div#portal_heading {
  align-self: flex-start;
  display: flex;
  align-items: center;
  margin: 0.5rem;
}

a#favicon {
  display: grid;
  margin: 0;
  padding: 0;
  border-style: none;
  border-width: 0;
  text-decoration: none;
}

a#favicon img {
  width: 2rem;
  height: 2rem;
  margin-left: 0.25rem;
  margin-right: 0.25rem;
}

body > header > div#portal_heading > h1 {
  margin: 0;
  padding: 0;
  padding-right: 1rem;
  padding-left: 0.5rem;
  white-space: nowrap;
}

body > header > ol#header_links {
  display: flex;
  align-items: center;
  margin: 0.5rem;
  padding: 0;
}

body > header > ol#header_links > li {
  display: grid;
  margin: 0;
  margin-right: 0.5rem;
  margin-left: 0.5rem;
  white-space: nowrap;
}

body > header > ol#header_links > li > a, body > header > ol#header_links > li > a:link, body > header > ol#header_links > li > a:visited {
  display: grid;
  text-decoration: none;
  color: inherit;
}

body > header > ol#header_links > li > a > img {
  width: 2rem;
  height: 2rem;
}

body > div#middle {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
}

body > div#middle > nav {
  margin-top: 1rem;
  margin-right: 1rem;
}

body > div#middle > nav > ol {
  margin: 0;
  padding: 0;
  list-style-type: none;
}

body > div#middle > nav > ol > li {
  margin: 0.5rem;
  white-space: nowrap;
}

body > div#middle > nav > ol > li > label {
  display: block;
  padding: 0.25rem;
  padding-left: 0.5rem;
  cursor: pointer;
}

body > div#middle > main {
  flex-grow: 1;
}

section.group {
  display: none;
  flex-direction: column;
  padding: 0.5rem;
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
  margin: 0.5rem;
  display: flex;
  flex-direction: column;
}

div.channel_chrome > header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0.5rem;
  margin-top: 0.25rem;
  margin-bottom: 0.25rem;
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

label.channel_maximize, label.channel_close {
  flex-grow: 1;
  display: block;
  margin: 0;
  margin-right: 0.5rem;
  margin-left: 0.5rem;
  width: 2rem;
  height: 2rem;
  padding: 0;
  cursor: pointer;
}

.channel_control_icon {
  fill: none;
  stroke: black;
}

.channel_content {
  flex-basis: 30rem;
  flex-grow: 1;
  margin: 0.5rem;
  margin-top: 0;
  border-width: inherit;
}

body > footer {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0;
}

body > footer > address {
  margin: 0.5rem;
  padding: 0;
  padding-left: 0.5rem;
  padding-right: 0.5rem;
}

body > footer > address a, body > footer > address a:link, body > footer > address a:visited {
  text-decoration: none;
  color: inherit;
}

body > footer > ol#footer_links {
  display: flex;
  align-items: center;
  margin: 0.5rem;
  margin-top: 0.25rem;
  margin-bottom: 0.25rem;
  padding: 0;
}

body > footer > ol#footer_links > li {
  display: grid;
  margin: 0;
  margin-right: 0.5rem;
  margin-left: 0.5rem;
  white-space: nowrap;
}

body > footer > ol#footer_links > li > a, body > footer > ol#footer_links > li > a:link, body > footer > ol#footer_links > li > a:visited {
  display: grid;
  text-decoration: none;
  color: inherit;
}

body > footer > ol#footer_links > li > a > img {
  width: 1.8rem;
  height: 1.8rem;
}

ol#channel_size_control {
  display: none;
  align-items: center;
  margin: 0.5rem;
  margin-top: 0.25rem;
  margin-bottom: 0.25rem;
  padding: 0;
}

ol#channel_size_control > li {
  display: flex;
  flex-grow: 1;
  margin: 0;
  margin-left: 0.5rem;
  margin-right: 0.5rem;
  padding: 0;
  width: 1.8rem;
  height: 1.8rem;
}

ol#channel_size_control > li > label {
  display: flex;
  flex-grow: 1;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  border-style: solid;
  border-color: transparent;
}

ol#channel_size_control > li > label > span {
  display: block;
  background-color: black;
}

li#ChannelSizeItem_1 > label > span {
  width: 0.5em;
  height: 0.5em;
}

li#ChannelSizeItem_2 > label > span {
  width: 0.7em;
  height: 0.7em;
}

li#ChannelSizeItem_3 > label > span {
  width: 0.9em;
  height: 0.9em;
}

li#ChannelSizeItem_4 > label > span {
  width: 1.2em;
  height: 1.2em;
}

li#ChannelSizeItem_5 > label > span {
  width: 1.5em;
  height: 1.5em;
}

input#ChannelSizeRadio-1:checked ~ footer > ol#channel_size_control > li#ChannelSizeItem_1 > label,
input#ChannelSizeRadio-2:checked ~ footer > ol#channel_size_control > li#ChannelSizeItem_2 > label,
input#ChannelSizeRadio-3:checked ~ footer > ol#channel_size_control > li#ChannelSizeItem_3 > label,
input#ChannelSizeRadio-4:checked ~ footer > ol#channel_size_control > li#ChannelSizeItem_4 > label,
input#ChannelSizeRadio-5:checked ~ footer > ol#channel_size_control > li#ChannelSizeItem_5 > label {
  border-color: red;
}

@media (min-width: 50rem) {

  body > div#middle {
    flex-direction: row;
    align-items: flex-start;
  }

  body > div#middle > nav {
    margin-right: 0;
  }

  section.group {
    flex-direction: row;
    align-items: flex-start;
    flex-wrap: wrap;
  }

  input#ChannelSizeRadio-1:checked ~ div#middle > main > section.group > section.channel {
    flex-basis: 15rem;
  }

  input#ChannelSizeRadio-1:checked ~ div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 30rem;
  }

  input#ChannelSizeRadio-2:checked ~ div#middle > main > section.group > section.channel {
    flex-basis: 25rem;
  }

  input#ChannelSizeRadio-2:checked ~ div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 35rem;
  }

  input#ChannelSizeRadio-3:checked ~ div#middle > main > section.group > section.channel {
    flex-basis: 35rem;
  }

  input#ChannelSizeRadio-3:checked ~ div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 40rem;
  }

  input#ChannelSizeRadio-4:checked ~ div#middle > main > section.group > section.channel {
    flex-basis: 50rem;
  }

  input#ChannelSizeRadio-4:checked ~ div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 50rem;
  }

  input#ChannelSizeRadio-5:checked ~ div#middle > main > section.group > section.channel {
    flex-basis: 70rem;
  }

  input#ChannelSizeRadio-5:checked ~ div#middle > main > section.group > section.channel > div.channel_chrome > .channel_content {
    flex-basis: 70rem;
  }

  ol#channel_size_control {
    display: flex;
  }

}

]]>
            </xsl:text>

            <xsl:for-each select="body/outline">

              <!-- Display the content section for a group when it's nav radio is checked. -->
              <xsl:text>&#x0A;input#GroupNavRadio-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text>:checked ~ div#middle > main > section#Group-</xsl:text>
              <xsl:call-template name="write_group_id" />
              <xsl:text> {&#x0A;  display: flex;&#x0A;}&#x0A;</xsl:text>

              <xsl:for-each select="outline">

                <!-- Maximize the channel section when it's maximize box is checked. -->
                <xsl:text>&#x0A;input#ChannelMaximizeCheckbox-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text>:checked ~ div#middle > main > section.group > section#Channel-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text> {&#x0A;  position: absolute;&#x0A;  width: 100%;&#x0A;  height: 100%;&#x0A;  top: 0;&#x0A;  left: 0;&#x0A;}&#x0A;</xsl:text>

                <!-- Don't display the channel close control when it's maximize box is checked. -->
                <xsl:text>&#x0A;input#ChannelMaximizeCheckbox-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text>:checked ~ div#middle > main > section.group > section#Channel-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text> > div.channel_chrome > header > div.channel_controls > label.channel_close {&#x0A;  display: none;&#x0A;}&#x0A;</xsl:text>

                <!-- Don't display the channel when it's close box is checked. -->
                <xsl:text>&#x0A;input#ChannelCloseCheckbox-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text>:checked ~ div#middle > main > section.group > section#Channel-</xsl:text>
                <xsl:call-template name="write_channel_id" />
                <xsl:text> {&#x0A;  display: none;&#x0A;}&#x0A;</xsl:text>

              </xsl:for-each>

            </xsl:for-each>

          </xsl:with-param>
        </xsl:call-template><!-- style_inline -->

        <xsl:if test="$www-eee-default-theme-disable = 'false'">
          <xsl:call-template name="style_inline">
            <xsl:with-param name="id" select="'default_theme_style'" />
            <xsl:with-param name="style">

              <xsl:text>:root {&#x0A;</xsl:text>

              <xsl:text>  --www-eee-body-background: </xsl:text>
              <xsl:value-of select="$www-eee-body-background" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-body-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-body-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-raised-background: </xsl:text>
              <xsl:value-of select="$www-eee-raised-background" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-raised-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-raised-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-border-color: </xsl:text>
              <xsl:value-of select="$www-eee-border-color" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-content-background: </xsl:text>
              <xsl:value-of select="$www-eee-content-background" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-content-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-content-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-portal-heading-background: </xsl:text>
              <xsl:value-of select="$www-eee-portal-heading-background" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-portal-heading-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-portal-heading-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-header-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-header-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-nav-active-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-nav-active-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-nav-inactive-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-nav-inactive-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-channel-title-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-channel-title-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-channel-control: </xsl:text>
              <xsl:value-of select="$www-eee-channel-control" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>  --www-eee-footer-foreground: </xsl:text>
              <xsl:value-of select="$www-eee-footer-foreground" />
              <xsl:text>;&#x0A;</xsl:text>

              <xsl:text>}&#x0A;</xsl:text>

              <xsl:text>
<![CDATA[

body {
  background-color: var(--www-eee-body-background);
  color: var(--www-eee-body-foreground);
}

body > header {
  background-color: var(--www-eee-raised-background);
  color: var(--www-eee-header-foreground);
  border-style: outset;
  border-color: var(--www-eee-border-color);
  border-top: none;
  border-right: none;
  border-left: none;
}

body > header > div#portal_heading {
  background-color: var(--www-eee-portal-heading-background);
  color: var(--www-eee-portal-heading-foreground);
  border-style: inset;
  border-color: var(--www-eee-border-color);
}

body > div#middle > nav {
  background-color: var(--www-eee-raised-background);
  color: var(--www-eee-nav-inactive-foreground);
  border-style: outset;
  border-color: var(--www-eee-border-color);
  border-left: none;
}

body > div#middle > nav > ol > li > label {
  font-size: larger;
}

section.channel {
  background-color: var(--www-eee-body-background);
}

div.channel_chrome {
  background-color: var(--www-eee-raised-background);
  color: var(--www-eee-channel-title-foreground);
  border-style: outset;
  border-color: var(--www-eee-border-color);
}

.channel_control_icon {
  stroke: var(--www-eee-channel-control);
}

.channel_content {
  border-style: inset;
  border-color: var(--www-eee-border-color);
  background-color: var(--www-eee-content-background);
  color: var(--www-eee-content-foreground);
}

body > footer {
  background-color: var(--www-eee-raised-background);
  color: var(--www-eee-footer-foreground);
  border-style: outset;
  border-color: var(--www-eee-border-color);
  border-right: none;
  border-bottom: none;
  border-left: none;
}

body > footer > address {
  font-style: normal;
}

ol#channel_size_control > li > label > span {
  background-color: var(--www-eee-channel-control);
}

]]>
              </xsl:text>

              <xsl:for-each select="body/outline">

                <!-- Highlight the navigation tab for a group when it's nav radio is checked. -->
                <xsl:text>&#x0A;input#GroupNavRadio-</xsl:text>
                <xsl:call-template name="write_group_id" />
                <xsl:text>:checked ~ div#middle > nav > ol > li#GroupNavItem-</xsl:text>
                <xsl:call-template name="write_group_id" />
                <xsl:text> {&#x0A;  background-color: var(--www-eee-body-background);&#x0A;  color: var(--www-eee-nav-active-foreground);&#x0A;  font-weight: bold;&#x0A;  border-style: inset;&#x0A;  border-color: var(--www-eee-border-color);&#x0A;  border-right: none;&#x0A;  margin-right: -0.19rem;&#x0A;}&#x0A;</xsl:text>

              </xsl:for-each>

            </xsl:with-param>
          </xsl:call-template><!-- style_inline -->
        </xsl:if><!-- $www-eee-default-theme-disable = 'false' -->

        <xsl:if test="($www-eee-includes-document) and ((document($www-eee-includes-document)//html:html/html:style[@id='custom_style']) or (document($www-eee-includes-document)//html:html/html:style[@id='custom_style_active_group']))">
          <xsl:call-template name="style_inline">
            <xsl:with-param name="id" select="'custom_style'" />
            <xsl:with-param name="style">

              <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:style[@id='custom_style']/node()" mode="identity" />

              <xsl:if test="document($www-eee-includes-document)//html:html/html:style[@id='custom_style_active_group']">
                <xsl:for-each select="body/outline">
                  <xsl:text>&#x0A;input#GroupNavRadio-</xsl:text>
                  <xsl:call-template name="write_group_id" />
                  <xsl:text>:checked ~ div#middle > nav > ol > li#GroupNavItem-</xsl:text>
                  <xsl:call-template name="write_group_id" />
                  <xsl:text> {&#x0A;</xsl:text>
                  <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:style[@id='custom_style_active_group']/node()" mode="identity" />
                  <xsl:text>}&#x0A;</xsl:text>
                </xsl:for-each>
              </xsl:if>

            </xsl:with-param>
          </xsl:call-template><!-- style_inline -->
        </xsl:if>

      </xsl:element><!-- head -->

      <xsl:element name="body">

        <xsl:for-each select="body/outline">

          <!-- Thanks to Art Lawry and Chris Coyier for pioneering this style of "Radio-Controlled Web Design". -->

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
              <xsl:text>GroupNavRadio-</xsl:text>
              <xsl:call-template name="write_group_id" />
            </xsl:attribute>
            <xsl:if test="position() = 1"><!-- Open the first group page by default. -->
              <xsl:attribute name="checked">
                <xsl:text>checked</xsl:text>
              </xsl:attribute>
            </xsl:if>
          </xsl:element>

          <xsl:for-each select="outline">

            <xsl:element name="input">
              <xsl:attribute name="type">
                <xsl:text>checkbox</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:text>state channel_maximize_state</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="id">
                <xsl:text>ChannelMaximizeCheckbox-</xsl:text>
                <xsl:call-template name="write_channel_id" />
              </xsl:attribute>
            </xsl:element>

            <xsl:element name="input">
              <xsl:attribute name="type">
                <xsl:text>checkbox</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="class">
                <xsl:text>state channel_close_state</xsl:text>
              </xsl:attribute>
              <xsl:attribute name="id">
                <xsl:text>ChannelCloseCheckbox-</xsl:text>
                <xsl:call-template name="write_channel_id" />
              </xsl:attribute>
            </xsl:element>

          </xsl:for-each><!-- channel outline -->

        </xsl:for-each><!-- group outline -->

        <xsl:call-template name="channel_size_input" />

        <xsl:if test="head/title">
          <xsl:element name="header">

            <xsl:element name="div">
              <xsl:attribute name="id">
                <xsl:text>portal_heading</xsl:text>
              </xsl:attribute>

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

              <xsl:element name="h1">
                <xsl:value-of select="head/title" />
              </xsl:element>

            </xsl:element><!-- div#portal_heading -->

            <xsl:if test="$www-eee-includes-document">
              <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:ol[@id='header_links']" mode="identity" />
            </xsl:if>

          </xsl:element><!-- header -->
        </xsl:if>

        <xsl:element name="div">
          <xsl:attribute name="id">
            <xsl:text>middle</xsl:text>
          </xsl:attribute>

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
                      <xsl:text>GroupNavRadio-</xsl:text>
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
                  </xsl:element>
                </xsl:element>
              </xsl:for-each>
            </xsl:element>
          </xsl:element><!-- nav -->

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

                        <xsl:element name="div">
                          <xsl:attribute name="class">
                            <xsl:text>channel_controls</xsl:text>
                          </xsl:attribute>

                          <xsl:element name="label">
                            <xsl:attribute name="class">
                              <xsl:text>channel_maximize</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="for">
                              <xsl:text>ChannelMaximizeCheckbox-</xsl:text>
                              <xsl:call-template name="write_channel_id" />
                            </xsl:attribute>
                            <xsl:call-template name="maximize_icon" />
                          </xsl:element>

                          <xsl:element name="label">
                            <xsl:attribute name="class">
                              <xsl:text>channel_close</xsl:text>
                            </xsl:attribute>
                            <xsl:attribute name="for">
                              <xsl:text>ChannelCloseCheckbox-</xsl:text>
                              <xsl:call-template name="write_channel_id" />
                            </xsl:attribute>
                            <xsl:call-template name="close_icon" />
                          </xsl:element>

                        </xsl:element><!-- div.channel_controls -->

                      </xsl:element><!-- header -->

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
                            <xsl:value-of select="$www-eee-channel-sandbox" />
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
                        </xsl:if>
                      </xsl:element><!-- iframe.channel_content -->

                    </xsl:element><!-- div.channel_chrome -->

                  </xsl:element><!-- section.channel -->
                </xsl:for-each><!-- channel outline -->

              </xsl:element><!-- section.group -->
            </xsl:for-each><!-- group outline -->

          </xsl:element><!-- main -->

        </xsl:element><!-- div.main -->

        <xsl:element name="footer">

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
                    <xsl:value-of select="head/ownerEmail" />
                  </xsl:element>
                  <xsl:text>&gt;</xsl:text>
                </xsl:element>
              </xsl:if>

            </xsl:element><!-- address -->
          </xsl:if><!-- owner info -->

          <xsl:if test="$www-eee-includes-document">
            <xsl:apply-templates select="document($www-eee-includes-document)//html:html/html:ol[@id='footer_links']" mode="identity" />
          </xsl:if>

          <xsl:element name="ol">
            <xsl:attribute name="id">
              <xsl:text>channel_size_control</xsl:text>
            </xsl:attribute>
            <xsl:call-template name="channel_size_label" />
          </xsl:element>

        </xsl:element><!-- footer -->

      </xsl:element><!-- body -->

    </xsl:element><!-- html -->

  </xsl:template><!-- opml -->

</xsl:stylesheet>
