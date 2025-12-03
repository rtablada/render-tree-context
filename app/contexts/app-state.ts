import { tracked } from '@glimmer/tracking';
import { makeContext } from 'render-tree-context/lib/context.gts';

export class AppState {
  @tracked userName;

  constructor() {
    this.userName = 'Guest';
  }
}

export const { Provider: ProvideAppState, consume } = makeContext(
  () => new AppState()
);
