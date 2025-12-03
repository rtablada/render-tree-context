import Component from '@glimmer/component';

import { on } from '@ember/modifier';
import { AppState, consume } from 'render-tree-context/contexts/app-state';
import type Owner from '@ember/owner';

export class UserName extends Component {
  appState: AppState;

  constructor(owner: Owner, args: {}) {
    super(owner, args);

    this.appState = consume();
  }

  updateUserName = (ev: InputEvent) => {
    this.appState.userName = ev.target?.value;
  };

  <template>
    <div>
      <label for="username">User Name: </label>
      <input
        id="username"
        type="text"
        value={{this.appState.userName}}
        {{on "input" this.updateUserName}}
      />
      <p>Your user name is: {{this.appState.userName}}</p>
    </div>
  </template>
}
