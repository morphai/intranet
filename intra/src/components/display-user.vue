<template>
  <v-tooltip bottom>
    <template v-slot:activator="{on}">
      <v-chip v-on="on">
        <v-avatar left>
          <v-img :src="user.photoURL"></v-img>
        </v-avatar>
        <span v-if="user.email == 'justice0408@gmail.com'">대표이사 / 김기현</span>
        <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">개발자 / daniel</span>
        <span v-else-if="user.email == 'kslee2471@gmail.com'">품질팀 / 이기섭</span>
        <span v-else-if="user.email == 'jgh208011@gmail.com'">생산팀 / 정귀홍</span>
        <span v-else-if="user.email == 'k01084119633@gmail.com'">품질팀 / 곽명순</span>
        <span v-else-if="user.email == 'kohh8611@gmail.com'">영업팀 / 고현호</span>
        <span v-else-if="user.email == 'jaewan77777@gmail.com'">구매팀 / 박재완</span>
        <!--
          <span v-else-if="user.email == 'yain369@gmail.com'">개발팀 / 박석진</span>
        -->
      </v-chip>
    </template>
    <span v-if="user.email == 'justice0408@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'daniel.kim7x@gmail.com'">khkim@shinwhaintec.co.kr | 010-7105-4882</span>
    <span v-else-if="user.email == 'kslee2471@gmail.com'">kslee@shinwhaintec.co.kr | 010-4022-2471</span>
    <span v-else-if="user.email == 'jgh208011@gmail.com'">ghjung@shinwhaintec.co.kr | 010-3821-3299</span>
    <span v-else-if="user.email == 'k01084119633@gmail.com'">msgwak@shinwhaintec.co.kr | 010-8411-9633</span>
    <span v-else-if="user.email == 'kohh8611@gmail.com'">hhko@shinwhaintec.co.kr | 010-4641-8611</span>
    <span v-else-if="user.email == 'jaewan77777@gmail.com'">jwpark@shinwhaintec.co.kr | 010-2706-2439</span>
    <!--
      <span v-else-if="user.email == 'yain369@gmail.com'">sjpark@shinwhaintec.co.kr | 010-2292-3888</span>
    -->
  </v-tooltip>
</template>
<script>
export default {
  props: ['user']
}
</script>

<!--
  신규인원추가시 순서
  0. App.vue 추가.
  1. 위에 두 내용 추가
  approvedLevel
  admin= 0,
  quality = 1,
  production = 2,
  purchase = 2,
  rnd = 3,
  sales = 4,
  pqc = 5
-->
