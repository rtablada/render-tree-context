import { pageTitle } from 'ember-page-title';

import { UserName } from '../components/UserName.gts';

import { Footer } from '../components/Footer.gts';
import {
  AppState,
  ProvideAppState,
} from 'render-tree-context/contexts/app-state';
import Component from '@glimmer/component';
import type Owner from '@ember/owner';

const myAppState = new AppState();
myAppState.userName = 'App Template User';

<template>
  <div style="border: 1px red solid;">
    <h2>This is not in any provider</h2>

    <UserName />
  </div>

  <ProvideAppState @value={{myAppState}}>
    {{pageTitle "TryContext"}}
    <h2 id="title">Welcome to Ember</h2>
    {{outlet}}

    <UserName />

    <Footer />
  </ProvideAppState>
</template>
