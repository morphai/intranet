<template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on" color="primary">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        {{user.displayName}}
      </v-chip>
    </template>
    <span>{{user.email}}</span>
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script>
