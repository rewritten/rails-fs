App.Views.Index = Backbone.View.extend({
    initialize: function() {
        this.items = this.options.items;
        this.render();
    },
    
    render: function() {
        var create_links = "<h3><a href='#new'>Create new subdir</a><a href='#new'>Upload new file</a></h3>"
        if(this.items.length > 0) {
            var out = create_links + "<ul>";
            _(this.items).each(function(item) {
                out += "<li class=" + item.type + "><a href='#" + item.path + "'>" + item.escape('name') + "</a></li>";
            });
            out += "</ul>";
            out += create_links
        } else {
            out = "<h3>No items!</h3>" + create_links;
        }
        $(this.el).html(out);
        $('#app').html(this.el);
    }
});


