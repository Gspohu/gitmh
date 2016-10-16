if ( ! Detector.webgl ) Detector.addGetWebGLMessage();
var click_on_element = 0;
var container;

var camera, cameraControls, scene, renderer, mesh;
var group;

var clock = new THREE.Clock();

init();
animate();


function init() {

 // renderer

renderer = new THREE.WebGLRenderer({antialias: true, alpha: true});
renderer.setSize(window.innerWidth, window.innerHeight);

container = document.createElement( \'div\' );
document.getElementById("file_repo_list_contain").appendChild( container );

container.appendChild(renderer.domElement);

camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 10000 );

cameraControls = new THREE.TrackballControls(camera, renderer.domElement);
cameraControls.target.set(0, 0, 0);

scene = new THREE.Scene();

// lights

light = new THREE.DirectionalLight( 0xffffff );
light.position.set( 1, 1, 1 );
scene.add( light );

light = new THREE.DirectionalLight( 0x002288 );
light.position.set( -1, -1, -1 );
scene.add( light );

light = new THREE.AmbientLight( 0x222222 );
scene.add( light );

/*material = new THREE.MeshBasicMaterial({
wireframe: true,
color: \'black\'
});*/
material = new THREE.MeshPhongMaterial( { color: 0x136BA1, specular: 0x1887CC, shininess: 100 } );

group = new THREE.Object3D();

// load mesh 
var loader = new THREE.STLLoader();
 loader.load(\''.$path_file.'\', modelLoadedCallback);

 window.addEventListener( \'resize\', onWindowResize, false );

 }

 function modelLoadedCallback(geometry) {

 mesh = new THREE.Mesh( geometry, material );
var bb = new THREE.Box3()
 bb.setFromObject(mesh);
bb.center(cameraControls.target);
group.add(mesh);
scene.add( group );

}

function onWindowResize() {

camera.aspect = window.innerWidth / window.innerHeight;
camera.updateProjectionMatrix();

renderer.setSize( window.innerWidth, window.innerHeight );

render();

}

function animate() {

var delta = clock.getDelta();

requestAnimationFrame(animate);

cameraControls.update(delta);

 if(click_on_element != 1) 
{
mesh.rotation.x += 0.001;
mesh.rotation.y += 0.001;
mesh.rotation.z += 0.001;
 }

renderer.render(scene, camera);

}
