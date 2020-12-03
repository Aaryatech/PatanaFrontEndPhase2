describe("Drawing geometry overlays",function(){var b,a,d,e,c;beforeEach(function(){b=b||new GMaps({el:"#map-with-polygons",lat:-12.0433,lng:-77.0283,zoom:12})});describe("A line",function(){beforeEach(function(){a=a||b.drawPolyline({path:[[-12.044,-77.0247],[-12.0544,-77.0302],[-12.0551,-77.0303],[-12.0759,-77.0276],[-12.0763,-77.0279],[-12.0768,-77.0289],[-12.0885,-77.0241],[-12.0908,-77.0227]],strokeColor:"#131540",strokeOpacity:0.6,strokeWeight:6})});it("should add the line to the polylines collection",function(){expect(b.polylines.length).toEqual(1);expect(b.polylines[0]).toEqual(a)});it("should be added in the current map",function(){expect(a.getMap()).toEqual(b.map)});it("should return the defined path",function(){var f=a.getPath().getAt(0);expect(parseFloat(f.lat().toFixed(4))).toEqual(-12.044);expect(parseFloat(f.lng().toFixed(4))).toEqual(-77.0247)})});describe("A rectangle",function(){beforeEach(function(){d=d||b.drawRectangle({bounds:[[-12.0303,-77.0237],[-12.0348,-77.0115]],strokeColor:"#BBD8E9",strokeOpacity:1,strokeWeight:3,fillColor:"#BBD8E9",fillOpacity:0.6})});it("should add the rectangle to the polygons collection",function(){expect(b.polygons.length).toEqual(1);expect(b.polygons[0]).toEqual(d)});it("should be added in the current map",function(){expect(d.getMap()).toEqual(b.map)});it("should have the defined bounds",function(){var i=parseFloat(d.getBounds().getSouthWest().lat().toFixed(4));var g=parseFloat(d.getBounds().getSouthWest().lng().toFixed(4));var f=parseFloat(d.getBounds().getNorthEast().lat().toFixed(4));var h=parseFloat(d.getBounds().getNorthEast().lng().toFixed(4));expect(i).toEqual(-12.0303);expect(g).toEqual(-77.0237);expect(f).toEqual(-12.0348);expect(h).toEqual(-77.0115)})});describe("A polygon",function(){beforeEach(function(){c=c||b.drawPolygon({paths:[[-12.0403,-77.0337],[-12.0402,-77.0399],[-12.05,-77.0244],[-12.0448,-77.0215]],strokeColor:"#25D359",strokeOpacity:1,strokeWeight:3,fillColor:"#25D359",fillOpacity:0.6})});it("should add the polygon to the polygons collection",function(){expect(b.polygons.length).toEqual(2);expect(b.polygons[1]).toEqual(c)});it("should be added in the current map",function(){expect(c.getMap()).toEqual(b.map)});it("should return the defined path",function(){var f=c.getPath().getAt(0);expect(parseFloat(f.lat().toFixed(4))).toEqual(-12.0403);expect(parseFloat(f.lng().toFixed(4))).toEqual(-77.0337)})});describe("A circle",function(){beforeEach(function(){e=e||b.drawCircle({lat:-12.040504866577,lng:-77.02024422636042,radius:350,strokeColor:"#432070",strokeOpacity:1,strokeWeight:3,fillColor:"#432070",fillOpacity:0.6})});it("should add the circle to the polygons collection",function(){expect(b.polygons.length).toEqual(3);expect(b.polygons[2]).toEqual(e)});it("should be added in the current map",function(){expect(e.getMap()).toEqual(b.map)});it("should have the defined radius",function(){expect(e.getRadius()).toEqual(350)})})});describe("Removing geometry overlays",function(){var b,a,d,e,c;beforeEach(function(){b=b||new GMaps({el:"#map-with-polygons",lat:-12.0433,lng:-77.0283,zoom:12})});describe("A line",function(){beforeEach(function(){a=b.drawPolyline({path:[[-12.044,-77.0247],[-12.0544,-77.0302],[-12.0551,-77.0303],[-12.0759,-77.0276],[-12.0763,-77.0279],[-12.0768,-77.0289],[-12.0885,-77.0241],[-12.0908,-77.0227]],strokeColor:"#131540",strokeOpacity:0.6,strokeWeight:6});b.removePolyline(a)});it("should remove the line from the polylines collection",function(){expect(b.polylines.length).toEqual(0);expect(a.getMap()).toBeNull()})});describe("A rectangle",function(){beforeEach(function(){d=b.drawRectangle({bounds:[[-12.0303,-77.0237],[-12.0348,-77.0115]],strokeColor:"#BBD8E9",strokeOpacity:1,strokeWeight:3,fillColor:"#BBD8E9",fillOpacity:0.6});b.removePolygon(d)});it("should remove the rectangle from the polygons collection",function(){expect(b.polygons.length).toEqual(0);expect(d.getMap()).toBeNull()})});describe("A polygon",function(){beforeEach(function(){c=b.drawPolygon({paths:[[-12.0403,-77.0337],[-12.0402,-77.0399],[-12.05,-77.0244],[-12.0448,-77.0215]],strokeColor:"#25D359",strokeOpacity:1,strokeWeight:3,fillColor:"#25D359",fillOpacity:0.6});b.removePolygon(c)});it("should remove the polygon from the polygons collection",function(){expect(b.polygons.length).toEqual(0);expect(c.getMap()).toBeNull()})});describe("A circle",function(){beforeEach(function(){e=b.drawCircle({lat:-12.040504866577,lng:-77.02024422636042,radius:350,strokeColor:"#432070",strokeOpacity:1,strokeWeight:3,fillColor:"#432070",fillOpacity:0.6});b.removePolygon(e)});it("should remove the circle from the polygons collection",function(){expect(b.polygons.length).toEqual(0);expect(e.getMap()).toBeNull()})})});