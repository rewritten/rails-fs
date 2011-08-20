var App = {
    Views: {},
    Routers: {},
    init: function() {
        new App.Routers.FsItems();
        Backbone.history.start();
    }
};


