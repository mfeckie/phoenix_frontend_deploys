import Ember from 'ember';

export default Ember.Component.extend({
  elementId: 'revision-list',
  ajax: Ember.inject.service(),
  store: Ember.inject.service(),
  active: Ember.computed('revisions.@each.active', function () {
    return this.get('revisions').find(revision => revision.get('active'));
  }),
  actions: {
    activateRevision(revision) {
      const ajax = this.get('ajax');
      const success = () => {
        this.get('store').findAll('revision');
      };

      ajax.post('/frontend_api/revisions/activate', {
        data: {
          revision: revision.id
        }
      }).then(success);
    }
  }
});
