var World = {
    name: "test",
    loaded: false,


    init: function initFn() {
        this.createOverlays();
    },

    createOverlays: function createOverlaysFn() {
        /*
            First a AR.TargetCollectionResource is created with the path to the Wikitude Target Collection(.wtc) file.
            This .wtc file can be created from images using the Wikitude Studio. More information on how to create them
            can be found in the documentation in the TargetManagement section.
            Each target in the target collection is identified by its target name. By using this
            target name, it is possible to create an AR.ImageTrackable for every target in the target collection.
         */
        this.targetCollectionResource = new AR.TargetCollectionResource("assets/tracker.wtc", {
            onError: World.onError
        });

        /*
            This resource is then used as parameter to create an AR.ImageTracker. Optional parameters are passed as
            object in the last argument. In this case a callback function for the onTargetsLoaded trigger is set. Once
            the tracker loaded all of its target images this callback function is invoked. We also set the callback
            function for the onError trigger which provides a sting containing a description of the error.

            To enable simultaneous tracking of multiple targets 'maximumNumberOfConcurrentlyTrackableTargets' has
            to be set.
            to be set.
         */
        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            onError: World.onError
        });

        
        this.reviewbutton = new AR.ImageResource("assets/reviewbutton.png");
        this.reviewbuttonoverlay =  new AR.ImageDrawable(this.reviewbutton, 1, {
            translate: {
                x: -0.15,
                y: -0.9
            }
        });
        World.reviewbuttonoverlay.onClick = function() {
            AR.platform.sendJSONObject({
                "image_clicked" : "review"
            });
        }


        /*
            Note that this time we use "*" as target name. That means that the AR.ImageTrackable will respond to
            any target that is defined in the target collection. You can use wildcards to specify more complex name
            matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or 'target*' for any targets
            names that start with 'target'.
         */
        this.stepTrackable = new AR.ImageTrackable(this.tracker, "*", {
            onImageRecognized: async function (target) {
                var stars = await getStars(target, World.name)
                if(stars === undefined){
                    /*var imageres = new AR.ImageResource("assets/reviewbutton.png");
                    var model = new AR.ImageDrawable(imageres, 1, {
                        translate: {
                            x: -0.15,
                            y: -0.9
                        },
                        onError: World.onError
                    });*/
                    this.addImageTargetCamDrawables(target, World.reviewbuttonoverlay);
                }
                var imageres = new AR.ImageResource("assets/" + stars + "ster.png");
                var model = new AR.ImageDrawable(imageres, 1, {
                    translate: {
                        x: -0.15,
                        y: -0.9
                    },
                    scale: { x: 0.4, y: 0.6},
                    onError: World.onError
                });
                this.addImageTargetCamDrawables(target, model);
            },
            onError: World.onError
        });
    },

    onError: function onErrorFn(error) {
        alert(error);
    },

    newData: function newDataFn(newName) {
        World.name = newName;
    }
};

World.init();

async function getStars(target, username){
    target = JSON.stringify(target.name);
    figure = target.match(/[a-zA-Z]+/g);
    const response = await fetch('https://edge-service-mathias270197.cloud.okteto.net/figureReviewByNameAndUser/' + figure + '/' + username,
        {
            method: "GET"
        }
    );  
    const data = await response.json();
    return JSON.stringify(data.stars);
}