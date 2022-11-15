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

        this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
            onError: World.onError
        });


        this.reviewbutton = new AR.ImageResource("assets/reviewbutton.png");
        this.reviewbuttonoverlay = new AR.ImageDrawable(this.reviewbutton, 1, {
            translate: {
                x: -0.15,
                y: -0.9
            }
        });


        this.stepTrackable = new AR.ImageTrackable(this.tracker, "*", {
            onImageRecognized: async function (target) {
                var stars = await getStars(target, World.name)
                if (stars === undefined) {
                    /*AR.platform.sendJSONObject({
                        "image_scanned" : target.name
                    });*/
                    this.addImageTargetCamDrawables(target, World.reviewbuttonoverlay)
                }
                //afbeelding wordt bepaald door de functie getstars
                var imageres = new AR.ImageResource("assets/" + stars + "ster.png");
                var model = new AR.ImageDrawable(imageres, 1, {
                    translate: {
                        x: -0.15,
                        y: -0.9
                    },
                    scale: { x: 0.4, y: 0.6 },
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
    //newData wordt gebruikt om de username op te halen
    newData: function newDataFn(newName) {
        World.name = newName;
    }
};

World.init();
//functie om het aantal sterren terug te krijgen van een user bij een bepaald figuur
async function getStars(target, username) {
    target = JSON.stringify(target.name);
    figure = target.match(/[a-zA-Z]+/g);
    const response = await fetch('https://edge-service-mathias270197.cloud.okteto.net/figureReviewByNameAndUser/' + figure + '/' + username,
        {
            method: "GET"
        }
    );
    const contentType = response.headers.get("content-type");
    if (contentType && contentType.indexOf("application/json") !== -1) {
        const data = await response.json();
        return(JSON.stringify(data.stars));
    } else {
        const stars = undefined;
        return stars
    }

}
