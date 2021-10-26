<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <site-title :title="title"></site-title>
      <v-spacer />
    </v-app-bar>
    <v-navigation-drawer app v-model="drawer">
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>
            Application
          </v-list-item-title>
          <v-list-item-subtitle>
            subtitle
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider></v-divider>
      <site-menu></site-menu>
    </v-navigation-drawer>
    <v-content>
      <router-view />
    </v-content>
    <site-footer :footer="footer"></site-footer>
  </v-app>
</template>

<script>

import siteTitle from '@/views/site/title'
import siteFooter from '@/views/site/footer'
import siteMenu from '@/views/site/menu'
export default {
  components: { siteTitle, siteFooter, siteMenu },
  name: 'App',
  data () {
    return {
      drawer: false,
      item: [],
      title: 'title 입니다.',
      footer: 'footer 입니다.'
    }
  }
}
</script>
