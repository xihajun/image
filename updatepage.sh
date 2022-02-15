#!/bin/bash
for i in img/*.svg
do
  echo "!["$i"]""("$i")" >> body.txt
done

for i in img/*.png
do
  echo "!["$i"]""("$i")" >> body.txt
done

cat > header.txt <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>bioInfograph</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Pacifico" type="text/css"> 
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Freckle+Face" type="text/css"> 

  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/jquery-ui.css">
  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/bootstrap.min.css">
  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/trash.css"/>
  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/gridstack.css"/>
  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/gridstack-extra.css"/>
  <link rel="stylesheet" href="https://baohongz.github.io/bioInfograph/dist/dropzone.css">

  <script src="https://baohongz.github.io/bioInfograph/dist/jquery.min.js"></script>
  <script src="https://baohongz.github.io/bioInfograph/dist/jquery-ui.min.js"></script>

  <script src="https://baohongz.github.io/bioInfograph/dist/bootstrap.min.js"></script>
  <script src="https://baohongz.github.io/bioInfograph/dist/lodash.min.js"></script>

<!-- https://gridstackjs.com : gridstack.js is a modern Typescript library designed to help developers create beautiful 
draggable, resizable, responsive bootstrap-friendly layouts with just a few lines of code. Each panel in the grid holds 
one image. Modifications are made to preserve inline styles, including positions, size and z-index after moving grid 
panel, see https://bit.ly/3CaOg3T for details. -->
  <script src="https://baohongz.github.io/bioInfograph/dist/gridstack.js"></script>
  <script src="https://baohongz.github.io/bioInfograph/dist/gridstack.jQueryUI.js"></script>

<!-- https://www.dropzone.dev/js : Dropzone.js is one of the most popular drag and drop JavaScript libraries. It is free, 
fully open-source, and makes it easy for you to handle dropped files on your website. Content of dropped/uploaded files 
will put into grid panels for layout. Modifications are made to allow emitting "previewReady" status when an image is fully 
loaded into memory and displayed in the preview box, see https://bit.ly/3Gup4Zp for details. -->
  <script src="https://baohongz.github.io/bioInfograph/dist/dropzone.js"></script>

<!-- https://github.com/bumbu/svg-pan-zoom : simple pan/zoom solution for SVG/png/gif/jpeg images in HTML, which offers 
JavaScript API for control of pan and zoom behavior and On-screen zoom controls. -->
  <script src="https://baohongz.github.io/bioInfograph/dist/svg-pan-zoom.js"></script>

<!-- https://github.com/iconfu/svg-inject : IDs in the SVG are made unique before injection to prevent ID conflicts in the 
DOM. Modifications: added function to set numeric portion of ID; exported functions to be global scope, see 
https://bit.ly/3Gus3kz for details. -->
  <script src="https://baohongz.github.io/bioInfograph/dist/svg-inject.js"></script>

  <script src="https://baohongz.github.io/bioInfograph/dist/FileSaver.min.js"></script>

<!-- https://www.tiny.cloud : The WYSIWYG editor that is flexible, customizable, and designed with the user in mind. -->
  <script src="https://baohongz.github.io/bioInfograph/dist/tinymce/tinymce.min.js"></script>
  <meta name="description" content="Add a gallery to your GitHub repository's markdown README.md file that contains screenshots and images of your project." />
  <script>
    window.onload = function() {

      var input = document.getElementById("input");
      var adjustor = document.getElementById("adjustor");
      var adjustorDisplay = document.getElementById("adjustor-display");
      var spacor = document.getElementById("spacor");
      var output = document.getElementById("output");


      var render = function(ev) {

        var text = "";
        // we do not base the calculation on 100% with to ensure
        // images fit despite borders, paddings or added spaces
        // that reduce the available width…
        var imagesPerRow = Math.round(90 / parseInt(adjustor.value));
        var re = /\[[^\]]+\]\(([^)]+)\)/g;
        while(url = re.exec(input.value)) { // assignement, not comparison!
          text +=   '<img'
                  + ' src="' + url[1] + '"'
                  + ' width="' + imagesPerRow + '%">'
                  + '</img>'
                  + (spacor.checked ? " " : "");
        }

        // update the preview
        preview.innerHTML = text;
        adjustorDisplay.innerHTML = adjustor.value;

        // update the code for the readme
        output.value = text;

      };

      input.addEventListener('keyup', render, false);
      adjustor.addEventListener('input', render, false);
      spacor.addEventListener('change', render, false);
      output.addEventListener('click', function() {
        this.focus();
        this.select();
      }, false);

      // call render once at startup
      render();

    };
  </script>
  <style type="text/css">
    *, *:before, *:after {
      box-sizing: border-box;
    }
    html, body {
      margin: 0;
      padding: 0;
      font: 13px/1.4 Helvetica, arial, nimbussansl, liberationsans, freesans, clean, sans-serif, "Segoe UI Emoji", "Segoe UI Symbol";
      color: #333;
      margin-bottom: 30px;
    }
    footer {
      position: fixed;
      text-align: left;
      border-top: 1px solid gray;
      background-color: #7D7D7D;
      color: white;
      bottom: 0px;
      left: 0;
      right: 0;
      padding-top: 5px;
    }
    footer span {
      vertical-align: super;
    }
    footer a {
      color: white;
    }
    body > .page {
      padding: 5px;
    }
    .page {
      max-width: 790px;
      margin: auto;
    }
    header {
      text-align: center;
      background: white;
    }
    #intro {
      text-align: center;
      background-color: #645555;
      padding: 20px;
      color: white;
      margin: 0;
      font-size: 1.1em;
    }
    #adjustor {
      width: 90%;
    }
    #output {
      height: 200px;
    }
    .step:not(.full-stretch) {
      float: left;
      width: 50%;
    }
    h3 span {
      font-size: 1.5em;
      color: #937373;
    }
    .full-stretch {
      clear: both;
    }
    table {
      border-collapse: collapse;
      width: 100%;
    }
    th {
      background-color: #EBEBEB;
    }
    tr > * {
      border: 1px solid #D8D8D8;
      padding: 5px;
    }
    #adjustor-display {
      display: inline-block;
      vertical-align: super;
    }
    #readme {
      margin: 30px 0;
      width: 100%;
    }
    #readme h3 {
      background-color: #f5f5f5;
      margin: 0;
      border: 1px solid #d8d8d8;
      border-bottom: 0;
      padding: 9px 10px 10px;
      font-size: 14px;
      line-height: 17px;
      display: block;
    }
    #readme h1 {
      margin-top: 0;
      text-align: left;
      border-bottom: 1px solid #eee;
      margin-bottom: 16px;
      padding-bottom: 0.3em;
    }
    #readme article {
      background-color: #fff;
      border: 1px solid #ddd;
      padding: 30px;
      word-wrap: break-word;
    }
    h1 {
      font-size: 2.25em;
      line-height: 1.2;
      font-weight: bold;
      line-height: 40px;
    }
    h2 {
      color: red
    }
    textarea {
      width: 100%;
      height: 4em;
    }
  </style>
  <style type="text/css">
    .dropzone {
      background: white;
      border-radius: 5px;
      padding: 10px 10px;
      border: 2px dashed #0087F7;
      border-image: none;
      width: 100%;
      height: 100%;
      margin-left: auto;
      margin-right: auto;
    }
    .dropzone .dz-message {
      margin: 0.2em 0;
    }
    .dragzidx {cursor: move;margin:2px;padding:2px;background:#0087F7;color:white;border-radius: 2px; width:55px; height:22px;}

    .trash {
      height: 200px;
      margin-bottom: 0px;
//    background-color: #f5f5f5 !important;
    }

    .grid-stack {
      background: white;
      border: 1px solid #0087F7;
    }

    .grid-stack .grid-stack-item .grid-stack-item-content, .grid-stack .grid-stack-placeholder > .placeholder-content {
      left: 0px;
      right: 0px;
      padding: 0px;
      overflow: hidden;
    }

    .grid-stack-item-content {
      background: none;
      text-align: center;
      border: 1px dashed red;
    }

    .grid-stack .grid-stack-placeholder > .placeholder-content {
      border: none;
    }

    .dropdown-menu {
      min-width: 200px;
      font-size: 12px;
    }

    @media print {
// Omit web components that are not parts of the figure.
// The following definitions in bootstrap.min.css might affect printing.
// *{color:#000!important;text-shadow:none!important;background:transparent!important;-webkit-box-shadow:none!important;box-shadow:none!important}
      .svg-pan-zoom-control {display: none;}
      .no-print {display: none;}
      #dragHandle {display: none;}
      #toggle-control {display: none;}
      .grid-stack {background: none; border:none;}
      .grid-stack .grid-stack-item .grid-stack-item-content, .grid-stack .grid-stack-placeholder > .placeholder-content { border: none; }
    }

    #dragHandle {
// The drag handle represented by a cross double-arrow sign on the top-right corner of a gird panel has a very high 
// z-index to ensure that it is on the top layer of graphical components in the grid panel.
      z-index: 999; width:16px; height: 16px; border-bottom: 0px solid #44c756;
      border-left: 0px solid #44c765; position: absolute;
      right: 0px; top: 0px; cursor: move;
      background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABQklEQVR42pWTS0/CQBSFz0S60VQwUK0gFsWYsDBuZOHGxF9O4sYFbowLEyPaikWUNuERdYHmektL6SMd8CaTzpw552tmeisgq30ivAghswhZ2DgHrGueSyAiM9wEBq+AtseQdjYkLVZuCMrxbFo+VdG7nfj69AGwz4QcoHO4H5hqY8rXVYw6DDA3RWo/Bah+0uzZ3QgB6xUVX3YEkPSEAH1MCpun9mSBzvEoqoDL2k/klQZrFmt9HyqwMyDoJcDLqpGwV988lMShPW2Lh+kA71pwsyWGbDPkw4mb66x1EprBmsWao4n4HRR7/vncsgjXjV3g/i2uRT2pr1C4IgwvAnOXcMJNcMfN4FZFaj+zDwotwtqRP58DvPp9BIaXS/pgXnmT0DQW67YFjGordmIIeWLIAYefOXz4z38hCpGElwNWqD88CnURPEHKNgAAAABJRU5ErkJggg==');
    }
    p {
      margin: 0 0 0px;
    }
    h1, .h1, h2, .h2, h3, .h3 {
      margin-top: 0px;
      margin-bottom: 0px;
    }
    .ui-dialog {z-index:9999;}
    .ui-dialog .ui-dialog-titlebar { background: #EFEFEF; padding: 0em 0.1em; }
    .ui-dialog .ui-dialog-titlebar-close
    {
      background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAgMAAABinRfyAAAADFBMVEXf4ueZmZnu7u53d3fvpLkJAAAAAXRSTlMAQObYZgAAAAFiS0dEAIgFHUgAAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQfkCxUONjYdLkxuAAAAKklEQVQI12NgQAMHmBkYmD/wH2Bg+GMP5Nr/ARL8H2AEmAuSgCgBKUYFAN0FC/Wtg65fAAAAAElFTkSuQmCC');
    }
  </style>
  <script type="text/javascript">
    $(function() {
// The pop-up dialog to show enlarged image in each grid panel with zoom, pan controls.
      $("#dialog-2").dialog({
        autoOpen: false,
        width: 'auto'
      });
    });
    var editorConfig = {
      selector: '.tinymce-body',
      menubar: false,
      browser_spellcheck: true,
      inline: true,
      plugins: [
        'link',
        'textcolor',
        'lists',
        'paste',
        'textpattern',
        'autolink'
      ],
// A simple markdown support is added by using tinymce text pattern plugin that matches special patterns in the text and 
// applies formats or executed commands on these patterns.
      textpattern_patterns: [
        {start: '*', end: '*', format: 'italic'},
        {start: '**', end: '**', format: 'bold'},
        {start: '#', format: 'h1'},
        {start: '##', format: 'h2'},
        {start: '###', format: 'h3'},
        {start: '####', format: 'h4'},
        {start: '#####', format: 'h5'},
        {start: '######', format: 'h6'},
        {start: '1. ', cmd: 'InsertOrderedList'},
        {start: '* ', cmd: 'InsertUnorderedList'},
        {start: '- ', cmd: 'InsertUnorderedList'}
      ],
      toolbar: [
        'undo redo | bold italic underline | fontselect fontsizeselect',
        'forecolor backcolor | alignleft aligncenter alignright alignfull | numlist bullist outdent indent'
      ],
      valid_elements: 'p[style],strong,em,span[style],a[href],ul,ol,li',
      valid_styles: {
        '*': 'font-size,font-family,color,text-decoration,text-align'
      },
      content_css: [
        '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
      ]
    };
    let drag = false; 
    document.addEventListener( 'mousedown', () => drag = false); 
    document.addEventListener( 'mousemove', () => drag = true); 

// Allowing grid panels to be overlapped with each other. 
    GridStackUI.Engine.prototype._fixCollisions = function(node) {};
  </script>
</head>

<body>
<div class="container" style="width:1152px;">
  <div class="row no-print">
    <div align=center>
      <a class="btn btn-default" id="add-new-Text">Add Text Box</a>
      <a class="btn btn-default" id="add-new-Control">Add Control</a>
      <a class="btn btn-default" id="save-HTML">Save as HTML/session</a>
      <div class="btn-group">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Demo</button>
        <div class="dropdown-menu" style="padding:4px;">
          Note: a demo file can be saved and loaded back as a session.<br>
          <a class="dropdown-item" href="https://baohongz.github.io/bioInfograph/figure/Fig1.html" target=_blank>Demo1</a><br>
          <a class="dropdown-item" href="https://interactivereport.github.io/Quickomics/Figure1.html" target=_blank>Demo2</a><br>
          <a class="dropdown-item" href="https://interactivereport.github.io/CellDepot/Figure2.html" target=_blank>Demo3</a>
        </div>
      </div><!-- /btn-group -->
      <a class="btn btn-default" href="https://baohongz.github.io/bioInfograph/help.html" target=_blank>Help</a>
      <input type="checkbox" class="custom-control-input" id="no-white-bg" checked>
      <label class="custom-control-label" for="no-white-bg">No White Background</label> | 
      <label>Opacity of</label> <input id="plot_sel" style="text-align:right;" size=5>:<input id="container_opacity_val" size=4 style="border:none;padding:0px;" onchange="setOpacity(this.value);">
      <input style="display: inline-block; width: 50px;" type="range" min="0" max="1" value="1" step="0.05" id="container_opacity" oninput="setOpacity(this.value);">
      <div class="btn-group">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">More</button>
        <div class="dropdown-menu" style="padding:4px;">
          <label>Zoom scale sensitivity</label>:<input id="zoom_scale_sen_val" size=4 style="border:none;padding:0px;"><br>
          <input style="display: inline-block; width: 100px;" type="range" min="0.005" max="0.1" value="0.1" step="0.005" id="zoom_scale_sen" oninput="setZoomScaleSen(this.value);"><br>
        </div>
      </div><!-- /btn-group -->
    </div>
  </div>
  <div class="row no-print" style="padding-top:5px;padding-bottom:3px;">
    <div id="list-1" style="width:80px;height:200px;overflow:auto;border:1px dashed red;float:left;z-index:200"></div>
    <div align=center class="col-xs-4" style="height:200px">
      <FORM class="dropzone needsclick" id="dropzoneUpload" action="/">
      <div class="dz-message needsclick">Drop an SVG (high resolution), JPEG, GIF, PNG or HTML session file here or click anywhere in the box to upload. Click "Add Text Box" to add a text input box to the canvas. Click and select text to format. Note: use open-source tool <b>Inkscape</b> (https://inkscape.org) to convert other formats to one of the acceptable formats, preferably SVG. Please use Chrome for the best experience.</div>
      </FORM>
    </div>
    <div align=center class="col-xs-4">
      <div class="trash"><br><span>Drop here to remove!</span></div>
    </div>
    <div align=center class="col-xs-3"><img width=240 height=200 src="https://baohongz.github.io/bioInfograph/bioInfograph_help.png"></div>
  </div> 
<!-- The whole canvas can be dragged up to get more working space. -->
  <div class="row" id="plotcanvas">
    <div id="grid-stack-holder" class="grid-stack"><div id="dragHandle"></div></div>
  </div>
</div>

<script type="text/javascript">
  var myFile = null; // Reference to the current uploaded file
  var num = 1;
  var imageId;
  var div_id;


// A sortable list to hold handles representing vertical stacking positions of grid panels by z-index.
  $("#list-1").sortable({
    start: function( event, ui ) {
      div_id = event.toElement.id.replace(/_hdl/,'');
// Highlight the image by changing background color.
      $('#'+div_id).css( "background-color", "lightgoldenrodyellow");  
    },
    stop: function( event, ui ) {
      div_id = event.toElement.id.replace(/_hdl/,'');
      $('#'+div_id).css( "background-color", 'transparent');

      var itemOrder = $('#list-1').sortable("toArray");
// Assign z-index number based on the order of panel handles in the list.
      for (var i = 0; i < itemOrder.length; i++) {
        div_id = itemOrder[i].replace(/_hdl/,'');
        $('#'+div_id).css( "z-index" , i+60 );
// console.log("Position: " + i + " ID: " + div_id);
      }
    }
  });

// To avoid dropping a plot to unwanted zone.
  window.addEventListener("dragover", function (e) {
    e.preventDefault();
    return;
  });
  window.addEventListener("drop", function (e) {
    e.preventDefault();
    return;
  });

// Click on the top title bar of a grid panel to select the panel to operate on, e.g. adjust opacity.
// Meanwhile, initiate the position of the slider and text to reflect the opacity value of the panel.
  function selectPlot (plot) {
    $('#plot_sel').val(plot);
    var opanum = parseFloat($('#'+plot+'_container')[0].style.opacity);
    setOpacity(opanum);

    setZoomScaleSen(0.1);
  }

// Set opacity value of the selected grid panel and change the position of the slider and text to reflect the value.
  function setOpacity (val) {
    $('#'+$('#plot_sel').val()+'_container')[0].style.opacity=val;
    document.getElementById('container_opacity_val').value = val; // text
    document.getElementById('container_opacity').value = val; // slider
  }

// Set zoom scale sensitivity
  function setZoomScaleSen (val) {
    var plot = $('#plot_sel').val();
    if (document.getElementById(plot).getElementById("svg-pan-zoom-controls") !== null) {
      svgPanZoom('#'+plot).setZoomScaleSensitivity(parseFloat(val));
      document.getElementById('zoom_scale_sen_val').value = val; // text
      document.getElementById('zoom_scale_sen').value = val; // slider
    } else {
      document.getElementById('zoom_scale_sen_val').value = 0.1; // text
      document.getElementById('zoom_scale_sen').value = 0.1; // slider
    }
  }

// Parse styles defined inside style tags.
  function parseStyles( styleTag ) {
    if ( !styleTag ) {
      return {};
    }
    const classCollection = {};
    
    const plain = styleTag.innerHTML.replace(/\s/g,'').toLowerCase();

    const regex = /([^\s{]+)[\s]*\{([\s\S]*?)\}/;
    const propertyRegex = /([\w\-]+)[\s]*:[\s]*([^;]+)/;
    const result = plain.match( new RegExp( regex, 'g' ) );
    if ( result ) {
      result.forEach( c => {
        const classResult = c.match( regex );
        const propertiesResult = classResult[ 2 ].match( new RegExp( propertyRegex, 'g' ) );
        if ( propertiesResult ) {
          const properties = propertiesResult.reduce( ( collection, item ) => {
            const p = item.match( propertyRegex );
            collection[ p[ 1 ] ] = p[ 2 ];
            return collection;
          },{});
          
          subclass = classResult[ 1 ].split(','); // multiple classes share one style definition
          subclass.forEach ( sc => {
            sc = sc.replace(/^\./,'');
            sc = sc.replace(/.*cls/,'cls');
            if (!classCollection[ sc ]) {
                  classCollection[ sc ] = properties;
            } else {
              classCollection[ sc ] = Object.assign(classCollection[sc], properties);
            }
          });
        }
      });
      return classCollection;
    }
    return {};
  }
  
// Apply parsed styles to an element with matching style classes.
  function applyStyles( element, styles ) {
    const classNames = ( element.getAttribute( 'class' ) || '' ).split( ' ' );
    classNames.forEach( c => {
      applyProperties( element, styles[ c ] );
    });
    element.setAttribute( 'class', '' );
  }

// Convert styles to local by embedding to the element.
  function applyProperties( element, properties ) {
    if ( !properties ) {
      return;
    }
    
    Object.keys( properties ).forEach( key => {
      element.style[ key ] = properties[ key ];
    });
  }
  
// Set up the Dropzone and attached listeners to various statuses.
  Dropzone.options.dropzoneUpload = {
    maxFiles:1,
    maxFilesize:256, // Megabytes
    maxThumbnailFilesize:256,   
    resizeQuality: 1,
    thumbnailWidth: null,
    thumbnailHeight: null,
    withCredentials: true,
    addRemoveLinks:true,

    init:function(){
      this.on("maxfilesexceeded",function(file){
        this.removeAllFiles();
        this.addFile(file);
      });
      this.on("success", function(file) {
// After successful uploading, myFile holds the reference of the uploaded file.
        myFile = file;

// If it is an image, change the size for previewing. Otherwise, process it as a session file.
        if (file.type.match(/image.*/)) {
// Set the size of an uploaded image in the preview box.
          var img = $(file.previewTemplate).find("img");
          img[0].width = 120;
          img[0].height = 120;
        } else {
// Process uploaded HTML session file to restore previous saved work including images.
          var fileReader = new FileReader;
          fileReader.onload = function(event) {
            var doc = document.createElement('div');
            doc.innerHTML = event.target.result.replace(/^.*?<body>(.*?)<\/body>.*?$/s,"$1");
            var locsize=""; 
// Parse properties of images stored in a JSON string. 
            if (event.target.result.match(/locsize=({.*?}});/)) {
              locsize = JSON.parse(RegExp.$1); 
            }
            Object.keys(locsize).forEach(function(myImg) {
// For each component, image or text box, add it to the canvas.
              addSessionSVG (doc.querySelector('#'+myImg+'_saved').innerHTML, myImg, locsize[myImg]);
              if (locsize[myImg].type == "plot-box" && $('#'+myImg)[0].querySelector('.svg-pan-zoom_viewport') !== null) {
// Get the transform matrix used to place image at the same location and scale.
                var matrix = $('#'+myImg)[0].querySelector('.svg-pan-zoom_viewport').transform.baseVal.consolidate().matrix;
// Attach an svg-zoom-pan control to the image panel.
                var panZoom = svgPanZoom('#'+myImg, {
                  zoomEnabled:true,
                  maxZoom:100,
                  minZoom:0.08,
                  zoomScaleSensitivity:0.1,
                  fit:false,
                  center:false,
                  controlIconsEnabled:true
                });
// Apply transformation to the image.
                panZoom.zoom(matrix.a);
                panZoom.pan({x: matrix.e, y: matrix.f});
// Change the location and size of the svg-pan-zoom control.
                document.getElementById(myImg).getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
              }
            });
            num += 1;
            this.removeAllFiles();
            myFile = null;
          }.bind(this); // bind Dropzone to the listener

          fileReader.readAsText(file);
        }
      });
      this.on("previewReady", function(file) {
// Add the image to a grid panel on the canvas after successful preview.
        addNewWidget("plot-box");
        this.removeAllFiles();
        myFile = null;
      });
      this.on("removedfile", function(file) {
        myFile = null;
      });
    }
  }

  addSessionSVG = function ( svg, imageId, node ) {
    var figureTitle = imageId+"_title";

// Create and add the grid panel (aka widget) to the canvas. Get image meta info from "node" variable.
    var el = this.grid.addWidget($('<div class=image_div id='+imageId+'z style="z-index:'+node.zindex+'; width:'+node.divwidth+'; height:'+node.divheight+'; left:'+node.left+'; top:'+node.top+';"><div class="grid-stack-item-content col-xs-4"><div class="tinymce-body" id='+figureTitle+' align="left"  onclick="selectPlot(\''+imageId+'\');initEditor\('+figureTitle+'\);this.focus\(\);">'+node.title+'</div><div id="'+imageId+'_container" class='+node.type+' style="opacity:1; width:100%; height:100%;">'+svg+'</div></div><div id="dragHandle"></div></div>'), node.x, node.y, node.width, node.height);

// Add the z-index handle (button) associated with the grid panel to the operation panel. 
    $('#list-1').append('<div id='+imageId+'z_hdl class="dragzidx" onclick="selectPlot(\''+imageId+'\');">'+imageId+'z</div>');
    selectPlot(imageId);

// Change the background color of activating plot while hovering over to make it eye-catching.
    $('#'+imageId+'z_hdl').hover(
      function () {
// textContent is the text in the <div> tag.
        div_id = this.textContent;
        $('#'+div_id).css("background-color", 'lightgoldenrodyellow');
        $('#'+div_id+'_hdl').css("background-color", 'lightgoldenrodyellow');
        $('#'+div_id+'_hdl').css("color", 'black');
      },
      function () {
        div_id = this.textContent;
        $('#'+div_id).css("background-color", 'transparent');
        $('#'+div_id+'_hdl').css("background-color", '#0087F7');
        $('#'+div_id+'_hdl').css("color", 'white');
      }
    );

    el.attr('data-custom-id', imageId);
    el.draggable({ handle: "#dragHandle" });
    if (el[0].querySelector(".plot-box")) {
// Add single-click listener to show enlarged image with zoom, pan controls in a pop-up window.
      el[0].querySelector(".plot-box").addEventListener('click', function (e) {
        if (drag || (e.path[0].classList[0] && e.path[0].classList[0].includes("svg-pan-zoom-control"))) return;
        var myImg = this.id.replace('_container','');
        $("#dialog-2").html(this.innerHTML.replace(myImg,myImg+'_popup'));
        $("#dialog-2 #svg-pan-zoom-controls").remove();
        $("#dialog-2").dialog("open");
        svgPanZoom('#'+myImg+'_popup', {
          zoomEnabled:true,
          maxZoom:100,
          minZoom:0.1,
          zoomScaleSensitivity:0.1,
          fit:true,
          center:true,
          controlIconsEnabled:true
        });
        document.getElementById(myImg+'_popup').getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
      });
    }

    if (num < parseInt(imageId.replace("plot",""))) {
      num = parseInt(imageId.replace("plot",""));
    }
    return false;
  }.bind(this);

// Set options of gridstack
  var options = {
    width: 48,
    removable: '.trash', // A panel will be removed if it is dropped into the trash bin
    removeTimeout: 100,
    verticalMargin: 0,
    cellHeight: 6,
    resizable: { handles: 'se, sw' },
//  alwaysShowResizeHandle: true,
    float: true
  };

// Pre-set locations of grid panels 
  this.items = [
    {x: 40, y: 60, width:  8, height: 30},
    {x: 32, y: 60, width:  8, height: 30},
    {x: 24, y: 60, width:  8, height: 30},
    {x: 16, y: 60, width:  8, height: 30},
    {x:  8, y: 60, width:  8, height: 30},
    {x:  0, y: 60, width:  8, height: 30},
    {x: 16, y: 30, width:  8, height: 30},
    {x:  8, y: 30, width:  8, height: 30},
    {x:  0, y: 30, width:  8, height: 30},
    {x: 16, y:  0, width:  8, height: 30},
    {x:  8, y:  0, width:  8, height: 30},
    {x:  0, y:  0, width:  8, height: 30}
  ];

  $('.grid-stack').gridstack(options);

  $('.grid-stack').on('dragstop', function (event, ui) {
    var element = $(event.target);
// Make trash area shorter to avoid panel moving over then being removed accidently when canvas is dragged up.
    if (element.context.id == "grid-stack-holder") {
      $(".trash").css("height",Math.min(200,200+parseInt(element.context.style.top)));
      return; // If design canvas is dragged.
    }
    var node = element.data('_gridstack_node');
    var removeId = ui.helper.context.id+'_hdl';
// Remove the linked z-index handle if a panel is dropped into the trash bin
    if (node._isAboutToRemove) {
      $('#'+removeId).remove();
    }
  });

  this.grid = $('.grid-stack').data('gridstack');
// Disable default dragging behavior
  this.grid.enableMove(false, false);
// Add dragging handle
  $("#grid-stack-holder").draggable({ handle: "#dragHandle" });

  this.initEditor = function (id) {
    tinymce.init(editorConfig);
  }

  this.addNewWidget = function (myType) {
    var svg = null;
    if (myType == "plot-box") {
// Get the encoded image from the preview thumbnail
      var images = myFile.previewElement.querySelectorAll("[data-dz-thumbnail]");
      if (images[0].src.match(/^data:image\/svg/)) {
// Decode encoded SVG image into a string
        svg = decodeURIComponent(escape(atob(images[0].src.replace(/^data:image\/.*;base64,/, ""))));
      } else {
// Link to the encoded source if the image is in other format, e.g. jpeg, gif or png
        svg = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><image width="600" height="600" xlink:href="'+images[0].src+'"/></svg>';
      }
    } else {
// For text box, use an invisible minimal element to give space to text
      svg = '<svg xmlns="http://www.w3.org/2000/svg"><g fill=white stroke=white stroke-width=0><circle cx=0 cy=0 r=1></g></svg>';
    }

    imageId = "plot"+num; 
    var wm=20, hm=20;

// Remove comments in svg string
    svg = svg.replace(/\/\*[^*]*\*\//g, "");

// Remove line breaks and extra spaces
    svg = svg.replace(/(\r\n|\n|\r)/gm," ").replace(/\s+/gm, " ");

// Attempt to get width and height of the image, otherwise set it to default
    if (svg.match(/viewBox=["|'][0-9.]+\s+[0-9.]+\s+([0-9.]+)\s+([0-9.]+)/)) {
      wm = RegExp.$1;
      hm = RegExp.$2;
    }
    if (wm <= 20 || hm <= 20) { 
      if (svg.match(/ width="(\d+)/)) {
        wm = RegExp.$1;
      } else {
        wm = 800;
      }
      if (svg.match(/ height="(\d+)/)) {
        hm = RegExp.$1;
      } else {
        hm = 800;
      }
    }

    var svgclass="";
    if (svg.match(/<svg[^>]+(class\s*=\s*[^\s]+)[^>]+>/)) svgclass = RegExp.$1;
// Set meta info of the svg string
    svg = svg.replace(/.*?<svg[^>]+>/i, '<svg xmlns="http://www.w3.org/2000/svg" id="'+imageId+'" style="display: inline; width: inherit; min-width: inherit; max-width: inherit; height: inherit; min-height: inherit; max-height: inherit; " width="'+wm+'" height="'+hm+'" viewBox="0 0 '+wm+' '+hm+'" '+svgclass+' version="1.1">');

// Avoid components with same names from different SVG files (svg-inject.js is modified to export few functions)
    svgElem = buildSvgElement(svg, false);
    if (svgElem.getElementById("svg-pan-zoom-controls") !== null) svgElem.getElementById("svg-pan-zoom-controls").remove();
    uniqueIdCounterNumber(num);
    makeIdsUnique(svgElem, false);
    svg = svgElemToSvgString(svgElem);

// Remove white background to make a plot transparent. It is based on how tools (R, Inkscape, cavasXpress, WikiPathways, Reactome or highcharts) handle background color.
// Tested on plots generated by computational biology related tools, e.g. R, Bioconductor packages, scanpy, WikiPathways, Reactome, and canvasXpress.
// "*" after a character means “zero or more” such character. "+" means "one or more".
    if ($('#no-white-bg').prop('checked')) {
      console.log('no-white-bg:'+$('#no-white-bg').prop('checked'));
      svg = svg.replace(/<path fill=\"#F+\"[^>]+d=\" *M[\d\. ]+h[\d\. ]+v[\d\. ]+H[\d\. ]+z[^>]+>/gi,"");
      svg = svg.replace(/<path fill=\"rgb\(255, *255, *255\)\"[^>]+d=\" *M[\d\. ]+L[\d\. ]+L[\d\. ]+L[\d\. ]+Z[^>]+>/gi,"");
      svg = svg.replace(/<path d=\" *M[\d\. ]+L[\d\. ]+L[\d\. ]+L[\d\. ]+Z *\" +style=\"fill: *#f+[^>]+>/gi,""); // scanpy
      svg = svg.replace(/<rect fill=\"rgb\(255,255,255\)\"[^>]+x=[^>]+\"\/>/,"");
      svg = svg.replace(/<rect x=\"0\" y=\"0\"[^>]+style=\"fill: *rgb\(100\%, *100\%, *100\%\);fill-opacity:1;[^>]+\"\/>/g,""); // PowerPoint->PDF->SVG (pdf2svg)
      svg = svg.replace(/<rect x=\"0\" y=\"0\"[^>]+style=\"fill: *rgb\(255, *255, *255\);fill-opacity:1;[^>]+\"\/>/g,""); // PowerPoint->PDF->SVG (pdf2svg)
/* Too generic
      svg = svg.replace(/fill: *rgb\(100\%, *100\%, *100\%\); *fill-opacity: *1;/gi,"fill:#ffffff;fill-opacity:0;");
      svg = svg.replace(/fill: *rgb\(255, *255, *255\); *fill-opacity: *1;/gi,"fill:#ffffff;fill-opacity:0;");
*/
      svg = svg.replace(/<rect[^>]+stroke: *none; *fill: *#F+;[^>]+\/>/gi,""); // R
      svg = svg.replace(/<rect[^>]+stroke: *#F+; *fill: *#F+;[^>]+\/>/gi,""); // R
      svg = svg.replace(/<rect fill=\"#f+\" class=\"highcharts-background\"/i,"<rect fill=\"none\" class=\"highcharts-background\""); // highcharts.js
      svg = svg.replace(/background: white;/gi,""); // WikiPathways
      svg = svg.replace(/<rect id=\"BG[^>]+\/>/gi,""); // Reactome
    }

    var node = this.items.pop();

// Set to this location if no more pre-defined locations. The grid panel can be moved freely by dragging after initial placement.
    if (node == null) {
      node =  { x: 0, y: 90, width: 8, height: 30 };
    }

    var figureTitle = imageId+"_title";
    var textHint = "&nbsp;";
    if (myType == "text-box") {
      textHint = "Type in text";
    }

    var initZindex = num+60; 
// Create and add the grid panel (aka widget) to the canvas.
    var el = this.grid.addWidget($('<div class=image_div id='+imageId+'z style="z-index:'+initZindex+';"><div class="grid-stack-item-content col-xs-4"><div class="tinymce-body" id='+figureTitle+' align="left"  onclick="selectPlot(\''+imageId+'\');initEditor\('+figureTitle+'\);this.focus\(\);">'+textHint+'</div><div id="'+imageId+'_container" class='+myType+' style="opacity:1; width:100%; height:100%;">'+svg+'</div></div><div id="dragHandle"></div></div>'), node.x, node.y, node.width, node.height);

// Add the z-index handle (button) associated with the grid panel to the operation panel. 
    $('#list-1').append('<div id='+imageId+'z_hdl class="dragzidx" onclick="selectPlot(\''+imageId+'\');">'+imageId+'z</div>');
    selectPlot(imageId);

// Change the background color of activating plot while hovering over to make it eye-catching.
    $('#'+imageId+'z_hdl').hover(
      function () {
// textContent is the text in the <div> tag.
        div_id = this.textContent;
        $('#'+div_id).css("background-color", 'lightgoldenrodyellow');
        $('#'+div_id+'_hdl').css("background-color", 'lightgoldenrodyellow');
        $('#'+div_id+'_hdl').css("color", 'black');
      },
      function () {
        div_id = this.textContent;
        $('#'+div_id).css("background-color", 'transparent');
        $('#'+div_id+'_hdl').css("background-color", '#0087F7');
        $('#'+div_id+'_hdl').css("color", 'white');
      }
    );
    num += 1;

    svgobj = el[0].firstChild.querySelector('#'+imageId+'_container') ;
// Parse styles defined in style tags.
    const styles = parseStyles( svgobj.querySelector( 'style' ) );
    const elements = svgobj.querySelectorAll( '[class]' );

// Deal with SVGs exported by R packages.
    for (var sty in styles) {
      if (sty == "circle" || sty == "line" || sty == "path" || sty == "polygon" || sty == "polyline" || sty == "rect") {
        shapes = svgobj.querySelectorAll(sty);  
        for (var j=0; j< shapes.length; j++) {
          Object.keys(styles[sty]).forEach( prop => {
// console.log(prop+"=>"+shapes[j].style[prop]);
            if (!shapes[j].style[prop]) {
              shapes[j].style[prop] = styles[sty][prop];
            }
          });
        }
      }
    }

// Unless it is defined as an SVG class, converting global style definition into local embedded inline style
// then removing global style definition to avoid conflicts of style definitions among SVG images.
    if (svgclass.length < 1) {
      for ( let j = 0; j < elements.length; j += 1 ) {
        applyStyles( elements[ j ], styles );
      }
      $('#'+imageId).find("style").remove();
    }

    el.attr('data-custom-id', imageId);
    el.draggable({ handle: "#dragHandle" });

// Add single-click listener to a plot-box to show enlarged image with additional zoom, pan controls.
    if (el[0].querySelector(".plot-box")) {
      el[0].querySelector(".plot-box").addEventListener('click', function (e) {
        if (drag || (e.path[0].classList[0] && e.path[0].classList[0].includes("svg-pan-zoom-control"))) return;
        var myImg = this.id.replace('_container','');
        $("#dialog-2").html(this.innerHTML.replace(myImg,myImg+'_popup')); 
        $("#dialog-2 #svg-pan-zoom-controls").remove();
        $("#dialog-2").dialog("open");
        svgPanZoom('#'+myImg+'_popup', {
          zoomEnabled:true,
          maxZoom:100,
          minZoom:0.1,
          zoomScaleSensitivity:0.1,
          fit:true,
          center:true,
          controlIconsEnabled:true
        });
        document.getElementById(myImg+'_popup').getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
      });
    }
  
    return false;
  }.bind(this);

  $('#add-new-Text').click( function() {
    addNewWidget("text-box");
  });

// Add svg-zoom-pan controls to a plot-box.
  $('#add-new-Control').click( function () {
    for (var i=1; i<num; i++) {
      var myImg = "plot"+i;
      var myContainer = myImg + "_container";
      if (document.getElementById(myImg) == null || document.getElementById(myContainer).classList.contains("text-box")) {
        continue;
      }

      if (document.getElementById(myImg).getElementById("svg-pan-zoom-controls") !== null) {
        continue;
      }

      svgPanZoom('#'+myImg, {
        zoomEnabled:true,
        maxZoom:100,
        minZoom:0.1,
        zoomScaleSensitivity:0.1,
        fit:true,
        center:true,
        controlIconsEnabled:true
      });
      document.getElementById(myImg).getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
    }
  });

  $('#save-HTML').click( function () {
    var locsize = new Object();
    _.map($('.grid-stack .grid-stack-item:visible'), function (el) {
      el = $(el);

      var node = el.data('_gridstack_node');
      var myid = el.attr('data-custom-id');
      var zm=1, panx=0, pany=0;
      if ($('#'+myid)[0].querySelector('.svg-pan-zoom_viewport') !== null) {
// Get the transformation matrix from svg-pan-zoom control.
        var matrix = $('#'+myid)[0].querySelector('.svg-pan-zoom_viewport').transform.baseVal.consolidate().matrix;
        zm = matrix.a, panx = matrix.e, pany = matrix.f;
      }
    
// Save meta info of an image.
      locsize[myid] = {
        // save additional stuff here, but no pointers or circular stuff!
        // You need to save every data that is needed to recreate the node
        // If you get the data from the server, it might be only the id
        id    : myid,
        title : $('#'+myid+'_title').html(),
        type  : $('#'+myid+'_container')[0].className,
        opacity: $('#'+myid+'_container').css('opacity'),
        zoom  : zm,
        pan   : {x: panx, y: pany},
        x     : node.x,
        y     : node.y,
        width : node.width,
        height: node.height,
        left: el[0].style['left'],
        top: el[0].style['top'],
        divwidth: el[0].style['width'],
        divheight: el[0].style['height'],
        zindex: el[0].style['z-index']
      };
    });

// Change the title of the saved HTML.
    var text = '<html>\n<head>\n'+$("head").html().replace(/<title>bioInfograph/,"<title>plot_by_bioInfograph")+'\n</head>\n<body>\n';
// Styles used to display saved HTML are in block1 div. Uncomment the text.
    text += $("#block1").html().replace(/<!--/g,'').replace(/-->/g,'');

// Store meta info of images into a hidden HTML div.
    console.log(JSON.stringify(locsize));
    text += '<div id=locsize style="display:none;">' + JSON.stringify(locsize) + '</div>';

    Object.keys(locsize).forEach(function(myImg) {
// Save encoded image.
      text += '<div id="'+myImg+'_saved" style="display:none;">';
      var $temp = $("<div></div>");
      $temp.append($('#'+myImg+'_container').html()).find("#svg-pan-zoom-controls").remove();
      var svg = $temp.html();
      text += svg;
      text += '</div>';
    });

// Store meta info of images into a JavaScript variable.
    text += '<script type="text/javascript">\n\$(function () {\n  var locsize='+JSON.stringify(locsize)+';';
// JavaScript used to display saved HTML is in block2 div. Uncomment the text.
    text = text + $("#block2").html().replace(/<!--/g,'').replace(/-->/g,'');

    var blob = new Blob([text], {type: "text/plain;charset=utf-8"});
    saveAs(blob, "plot_by_bioInfograph.html");
  });
  $("#grid-stack-holder").css("height",100);
</script>

<!-- Text in blocks is hidden and commented out so that it won't affect index.html. -->
<div id="block1" style="display:none;">
<!--
<style type="text/css">
  .grid-stack .grid-stack-item .grid-stack-item-content, .grid-stack .grid-stack-placeholder > .placeholder-content {
    left: 0px;
    right: 0px;
    padding: 0px;
    border: none;
    overflow: hidden;
  }
  
  .grid-stack {
    background: white;
    border: none;
  }
  .container .svg-pan-zoom-control {display: none;}
  .container .ui-draggable-handle {display: none;}
</style>
<div class="container" style="width:1152px;">
  <div class="row no-print"><a class="btn btn-default btn-sm" id="toggle-control">Show/Hide Control</a> | Click on individual panels to view enlarged plots | Press the left mouse button and drag to pan | Click on '+' or '-' control to zoom in or out | Press and drag borders to resize | Made by <a href="https://github.com/baohongz/bioInfograph">bioInfograph</a></div><br>
  <div class="row"> <div class="grid-stack">
  </div></div>
</div>
-->
</div>

<div id="block2" style="display:none;">
<!--
  $('#toggle-control').click( function () {
    $(".container .svg-pan-zoom-control").toggle();
    $(".container .ui-draggable-handle").toggle();
  });

  var options = {
    removable: '.trash',
    removeTimeout: 100,
    verticalMargin: 0,
    cellHeight: 6,
    resizable: { handles: 'se, sw' },
    float: true
  };

  $('.grid-stack').gridstack(options);

  this.grid = $('.grid-stack').data('gridstack');
  this.grid.enableMove(false, false);

  addSVG = function ( svg, imageId ) {
// Get meta info of an image and store in node.
    var node = locsize[imageId];
    var figureTitle = imageId+"_title";

// Create and add the grid panel (aka widget) to the canvas.
    var el = this.grid.addWidget($('<div style="z-index:'+node.zindex+'; width:'+node.divwidth+'; height:'+node.divheight+'; left:'+node.left+'; top:'+node.top+';"><div class="grid-stack-item-content col-xs-4"><div id='+figureTitle+' align="left" contenteditable="true"  onclick="this.focus\(\);">'+node.title+'</div><div id="'+imageId+'_container" class="'+node.type+'" style="opacity:'+node.opacity+'; width:100%; height:100%;">'+svg+'</div></div><div id="dragHandle"></div></div>'), node.x, node.y, node.width, node.height); 

    el.draggable({ handle: "#dragHandle" });
    return false;
  }.bind(this);

/* old way. using panZoom now.
  var CTMs = [];
  Object.keys(locsize).forEach(function(myImg) {
    CTMs[myImg] = $('#'+myImg)[0].querySelector('.svg-pan-zoom_viewport').getAttribute('transform');
  });
*/

  Object.keys(locsize).forEach(function(myImg) {
/*
    document.getElementById(myImg).onload = function(e) {
      $('#'+e.target.id)[0].querySelector('.svg-pan-zoom_viewport').setAttribute('transform',CTMs[e.target.id]);
      $('#'+e.target.id)[0].querySelector('.svg-pan-zoom_viewport').style.transform = CTMs[e.target.id];
    }
*/
    addSVG ($('#'+myImg+'_saved').html(), myImg);
    $('#'+myImg+'_saved').remove();
    var panZoom = svgPanZoom('#'+myImg, {
      zoomEnabled:false,
      maxZoom:100,
      minZoom:0.08,
      zoomScaleSensitivity:0.1,
      fit:false,
      center:false,
      controlIconsEnabled:true
    });
    panZoom.zoom(locsize[myImg].zoom);
    panZoom.pan(locsize[myImg].pan);
    document.getElementById(myImg).getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
  });

  $(".plot-box").click (function (e) {
    if (drag || e.originalEvent.target.className.baseVal.includes("svg-pan-zoom-control")) return;
    var myImg = this.id.replace('_container','');
    $("#dialog-2").html(this.innerHTML.replace(myImg,myImg+'_popup'));
    $("#dialog-2 #svg-pan-zoom-controls").remove();
    $("#dialog-2").dialog("open");
    svgPanZoom('#'+myImg+'_popup', {
      zoomEnabled:true,
      maxZoom:100,
      minZoom:0.1,
      zoomScaleSensitivity:0.1,
      fit:true,
      center:true,
      controlIconsEnabled:true
    });
    document.getElementById(myImg+'_popup').getElementById("svg-pan-zoom-controls").setAttribute('transform', 'translate(0  0) scale(0.6)');
  });
});
</script>
<div id="dialog-2"></div>
</body>
</html>
-->
</div>
<div id="dialog-2"></div>

<div class="page">
  <div class="step">
    <h3><span>①</span> Create markdown links at GitHub</h3>
    <ol>
      <li>Go to your GitHub project repository</li>
      <li>Open your issue list and click "New Issue"</li>
      <li>Drag'n'drop your images into the issue's textarea</li>
      <li>Copy the markdown code from the issue's textarea</li>
    </ol>
  </div>
  <div class="step">
    <h3><span>②</span> Paste the code into the textarea below</h3>
    <i>Remove the demo code below, then paste your code…</i>
    <textarea id="input">
EOF

cat > footer.txt <<EOF
        </textarea>
      </div>
      <div class="step full-stretch">
        <h3><span>③</span> Adjust your gallery like a boss.</h3>
        <table>
          <tr>
            <th>Images per Row</th>
            <th>Spacing</th>
          </tr>
          <tr>
            <td>
              <input id="adjustor" type="range" min="1" max="20" step="1" value="6" />
              <span id="adjustor-display"></span>
            </td>
            <td>
              <label>
                <input id="spacor" type="checkbox" name="spacor" value="1" checked>Add a space between the images
              </label>
            </td>
          </tr>
        </table>
        <div id="readme">
          <h3>README.md</h3>
          <article>
            <h1>Your Project</h1>
            <p id="preview"></p>
            <p>This is a preview of how the gallery will look in your repo's readme. Of course you can add multiple image galleries and separate them with text. Images that have the same aspect ratio will look better than images with different proportions.</p>
          </article>
        </div>
      </div>
      <div class="step full-stretch">
        <h3><span>④</span>  Now grab yer code and get outta here.</h3>
        Click into the textarea below to select the code. Then copy'n'paste it into your project's readme.md and you are good!
        By the way, you can also paste it into issues, that will work too!
        <textarea id="output"></textarea>
      </div>
    </div>
    <footer>
      <div class="page">
        <iframe src="https://ghbtns.com/github-btn.html?user=felixhayashi&repo=ReadmeGalleryCreatorForGitHub&type=star&count=true" frameborder="0" scrolling="0" width="80px" height="20px"></iframe>
        <span>
          Created by <a href="https://github.com/felixhayashi">@felixhayashi</a>. Free of any charge. Enjoy :)
        </span>
      </div>
    </footer>
  </body>
</html>
EOF

cat header.txt body.txt footer.txt > index.html