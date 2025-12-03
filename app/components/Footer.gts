import { UserName } from './UserName.gts';

import {
  AppState,
  ProvideAppState,
} from 'render-tree-context/contexts/app-state';

const footerAppState = new AppState();
footerAppState.userName = 'Footer User';

export const Footer = <template>
  <ProvideAppState @value={{footerAppState}}>

    <UserName />

  </ProvideAppState>
</template>;
