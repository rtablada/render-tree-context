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

export function makeContext<T>(factory: ContextFactory<T>): ContextResult<T> {
  const consumeSymbol = Symbol('context-consume');

  class LocalProvider extends ContextProvider<T> {
    symbol = consumeSymbol;
  }

  return {
    Provider: LocalProvider,
    consume: () => {
      return factory({} as Owner);
    },
  };
}
