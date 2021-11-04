<template>
  <v-main>
    <v-col cols="12">
      <v-img
        :src="require('../assets/intro-img.svg')"
        class="my-3"
        contain
        height="500"
      />
    </v-col>
    <v-col class="mt-3 text-center" >
        <h1 class="grey--text font-weight-medium mb-10">
          Shinwhaintech Database
        </h1>

        <p class="subheading font-weight-regular">
          데이터베이스 사용을 위해 우측 상단에 로그인을 하셔야 화면이 활성화 됩니다.
          <br>에러 발생시 관리자에게 문의 바랍니다.
        </p>
      </v-col>
    <v-col class="mt-1 text-center">
      <v-btn rounded color="primary" dark large class="my-2">우측 상단에 로그인 하세요</v-btn>
    </v-col>
  </v-main>
</template>

<script>
export default {
}
</script>
