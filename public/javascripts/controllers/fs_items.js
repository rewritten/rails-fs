App.Controllers.FsItems = Backbone.Controller.extend({
    routes: {
        "fs_items/:id":            "edit",
        "":                         "index",
        "new":                      "newDoc"
    },
    
    edit: function(id) {
        var item = new FsItem({ id: id });
        item.fetch({
            success: function(model, resp) {
                new App.Views.Edit({ model: item });
            },
            error: function() {
                new Error({ message: 'Could not find that item.' });
                window.location.hash = '#';
            }
        });
    },
    
    index: function() {
        $.getJSON('/browse/by_path', function(data) {
            if(data) {
                var items = _(data).map(function(i) { return new FsItem(i); });
                new App.Views.Index({ items: items });
            } else {
                new Error({ message: "Error loading documents." });
            }
        });
    },
    
    newItem: function() {
        new App.Views.Edit({ model: new FsItem() });
    }
});

