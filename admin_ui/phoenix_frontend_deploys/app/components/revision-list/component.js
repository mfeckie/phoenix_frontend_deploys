import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'table',
  elementId: 'revision-list',
  ajax: Ember.inject.service(),
  actions: {
    activateRevision(revision) {
      const ajax = this.get('ajax');
      ajax.post('/test/api/revisions/activate', {
        data: {
          revision: revision.id
        }
      });
    }
  }
});
