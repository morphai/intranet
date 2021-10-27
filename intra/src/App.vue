<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <v-app-bar-nav-icon @click="drawer = !drawer" />
      <site-title :title="site.title"></site-title>
      <v-spacer />
      <site-sign></site-sign>
    </v-app-bar>
    <v-navigation-drawer app v-model="drawer" width="400">
      <site-menu :items="site.menu"></site-menu>
    </v-navigation-drawer>
    <v-content>
      <router-view />
    </v-content>
    <site-footer :footer="site.footer"></site-footer>
  </v-app>
</template>

<script>

import siteTitle from '@/views/site/title'
import siteFooter from '@/views/site/footer'
import siteMenu from '@/views/site/menu'
import siteSign from '@/views/site/sign'
export default {
  components: { siteTitle, siteFooter, siteMenu, siteSign },
  name: 'App',
  data () {
    return {
      drawer: false,
      site: {
        menu: [
          {
            title: 'home',
            icon: 'mdi-home',
            subItems: [
              {
                title: 'Dashboard',
                to: '/'
              },
              {
                title: 'About',
                to: '/about'
              }
            ]
          },
          {
            title: 'about',
            icon: 'mdi-information',
            active: true,
            subItems: [
              {
                title: 'xxx',
                to: '/xxx'
              }
            ]
          }
        ],
        title: 'title 입니다.',
        footer: 'footer 입니다.'
      }
    }
  },
  created () {
    this.subscribe()
  },
  methods: {
    subscribe () {
      this.$firebase.database().ref().child('site').on('value', (sn) => {
        const v = sn.val()
        if (!v) {
          this.$firebase.database().ref().child('site').set(this.site)
          return
        }
        this.site = v
      }, (e) => {
        console.log(e.message)
      })
    }
  }
}
</script>
