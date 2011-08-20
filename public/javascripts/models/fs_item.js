var FsItem = Backbone.Model.extend({
    url : function() {
      var base = 'fs_items';
      if (this.isNew()) return base;
      return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.path;
    },
    parse : function(resp, xhr) {
      if (!!resp['directory']) {
        ob = resp.directory
        ob.type = 'directory'
      } else {
        ob = resp.file_item
        ob.type = 'file_item'
      }
      return ob;
    },
    initialize_ : function(attributes, options) {
      if (!!options.is_directory)
      {
        this.type = 'directory';
      } else {
        this.type = 'file_item';
      }
    }
});

