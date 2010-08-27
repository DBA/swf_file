# swf_file gem history

## v1.1.0 (27-Aug-2010)

In order to avoid namespace conflicts, SwfFile is no longer a class, instead it is a module.

Where you previously used:

<pre>SwfFile.new or SwfFile.header</pre>

Now you'll have to use

<pre>SwfFile::FlashFile.new or SwfFile::FlashFile.header</pre>