import DS from 'ember-data';

export default DS.Model.extend({
  size: DS.attr(),
  mtime: DS.attr()
});
