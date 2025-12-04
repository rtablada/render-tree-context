import type Owner from '@ember/owner';
import Component from '@glimmer/component';

type ContextFactory<T> = (owner: Owner) => T;

interface ContextProviderSignature<T> {
  Args: {
    value: T;
  };
  Blocks: {
    default: [];
  };
}

abstract class ContextProvider<T> extends Component<
  ContextProviderSignature<T>
> {
  abstract symbol: symbol;
}

interface ContextResult<T> {
  Provider: unknown;
  consume: () => T;
}

function getAppOwner() {
  return window.emberApp;
}

function* getParentComponents() {
  const owner = getAppOwner();
  if (!owner) {
    return;
  }

  const domRenderer = owner.__container__.lookup('renderer:-dom');
  if (!domRenderer) {
    throw new Error(`BUG: owner is missing renderer`);
  }
  // SAFETY: Ideally we'd assert here but that causes awkward circular requires since this is also in @ember/debug.
  // This is only for debug stuff so not very risky.
  const stack = domRenderer.debugRenderTree.stack.stack;
  for (let i = stack.length - 1; i >= 0; i--) {
    const frame = stack[i];
    if (frame.state) {
      yield frame.state.component;
    }
  }
}

export function makeContext<T>(factory: ContextFactory<T>): ContextResult<T> {
  const consumeSymbol = Symbol('context-consume');

  class LocalProvider extends ContextProvider<T> {
    symbol = consumeSymbol;
  }

  return {
    Provider: LocalProvider,
    consume: () => {
      const tree = getParentComponents();

      for (const component of tree) {
        if (
          component instanceof ContextProvider &&
          component.symbol === consumeSymbol
        ) {
          return component.args.value;
        }
      }

      return factory({} as Owner);
    },
  };
}
