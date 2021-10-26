<template>
  <v-app>
    <v-app-bar
      app
      color="primary"
      dark
    >
      <v-app-bar-nav-icon />
      <v-toolbar-title>Page title</v-toolbar-title>
      <v-spacer />
      <v-btn icon to="/about"><v-icon>mdi-magazine-pistol</v-icon></v-btn>
      <v-btn icon to="/xxx"><v-icon>mdi-magazine-pistol</v-icon></v-btn>
    </v-app-bar>
    <v-content>
      <router-view />
    </v-content>
    <v-footer app color="primary" dark absolute>
      <v-spacer></v-spacer>
      <div>SHINWHAINTECH</div>
    </v-footer>
  </v-app>
</template>

<script>

export default {
  name: 'App'
}
</script>
