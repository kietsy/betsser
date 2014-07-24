# Betsser (WIP)

An indentation and space sensitive, but case insensitive alternative to the
Alloy's XML templates.

An alternative to [Alloy](https://github.com/appcelerator/alloy) since it seems
to break [Titanium](http://www.appcelerator.com/platform) functionality for
complex layouts and XML is not meant to be written by humans. So instead we
propose a markup based on [Jade]() which is parsed by a
[PEG.js](https://github.com/dmajda/pegjs) parser. The output is an Object tree
which in turn can be compiled into normal Alloy templates or native Titanium
code (yet to come).

Example:
``` XML
<View id="voting">
    <Button id="like" title="Like" />
    <Label id="score">likes</Label>
<\View>
```
Alternative in Jadestyle:
``` Jade
View id:voting
    Button id:like title:Like
    Label id:likeCount likes
```
Parser output:
``` JSON
{
    "name": "root",
    "properties": {},
    "children": [{
        "name": "View",
        "properties": {
            "id": "voting"
        },
        "content": "",
        "children": [{
            "name": "Button",
            "properties": {
                "id": "like",
                "title": "Like"
            },
            "content": "",
            "children": []
        }, {
            "name": "Label",
            "properties": {
                "id": "likeCount"
            },
            "content": "likes",
            "children": []
        }]
    }]
}
```


## Templates
### Alloy
``` XML
<Alloy>
	<Window>
		<ButtonBar platform="ios" onClick="sayHi">
			<!-- These get added to the TabbedBar "labels" array -->
			<Labels>
				<!-- Specify text with node text or "title" attribute. -->
				<Label>button 1</Label>
				<Label title="button 2"/>

				<!-- uses images and/or widths -->
				<Label width="40" image="/KS_nav_ui.png"/>

				<!-- set as disabled -->
				<Label enabled="false">disabled</Label>

				<!-- empty labels will print a warning (no properties) -->
				<!-- <Label/> -->
			</Labels>

			<!--
				additional views get added as normal, over the labels, as
			    per the documentation of the add() function.
			 -->
			<!-- <View opacity="0.25" backgroundColor="#a00" width="50%"/> -->
		</ButtonBar>
		<Label platform="android,mobileweb">Ti.UI.iOS.Toolbar only supported on iOS</Label>
	</Window>
</Alloy>
```

### Betsser
``` Jade
Window
  ButtonBar platform:ios onClick:sayHi
    // These get added to the TabbebBar "labels" array
    Labels
      // Specify text with node text or "title" attribute
      Label 'button 1'
      Label title:'button 2'
      // uses images and/or widths
      Label width:40 image:'/KS_nav_ui.png'
      // set as disabled
      Label enabled:false disabled
      // empty labels will print a warning (no properties)
      // Label
    // additional views get added as normal, over the labels as
    // per the documentation of the add() function.
    // View opacity:0.25 backgroundColor:#a00 width:50%
  Label platform:android,mobileweb 'Ti.UI.iOS.Toolbar only supported on iOS'
```

## TODO
* [ ] finish [grammar](https://github.com/despairblue/betsser/tree/master/grammar)
* [ ] generate parser
* [ ] write compiler to output xml templates
* [ ] write compiler to output native titanium code
* [ ] define public api
* [ ] add titanium elements and there specific properties (geez, that'll be a lot of typing)
* [ ] make all names case insensitive (output will have the right case)
* [ ] write CLI
* [ ] package for npm
* [ ] publish package

## Contributions

Open a pull request as early as possible. Consider opening a issue before you
start working on something to prevent duplication of work.

### Style Guide

For JavaScript stick to the [Airbnb JS style
guide](https://github.com/airbnb/javascript) with the additions of the [Github
style guide](https://github.com/styleguide/javascript), namely avoid semicolons
and use two spaces indentation.

## Other

Thanks to [PEG.js](http://pegjs.majda.cz/) for amazing parser generator.  
Thanks to [Blade](https://github.com/bminer/node-blade) for idea of forking Jade and using PEG.js.  
Thanks to [XJade](https://github.com/dorny/xjade) for the idea of thanking everyone.
