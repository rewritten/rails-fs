var App = {
    Views: {},
    Controllers: {},
    init: function() {
        new App.Controllers.FsItems();
        Backbone.history.start();
    }
};


