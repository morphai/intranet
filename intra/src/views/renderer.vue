<template>
  <board-index v-if="collection === 'board' && document === 'list'"></board-index>
  <board-content v-else-if="collection === 'board' && !action" :document="document"></board-content>
  <board-form v-else-if="collection === 'board' && action === 'board-write'" :document="document" :action="action"></board-form>
  <board-article-form v-else-if="collection === 'board' && action === 'article-write'" :document="document" :action="action"></board-article-form>
  <page-index v-else-if="collection === 'page' && document === 'list'"></page-index>
  <page-content v-else-if="collection === 'page'" :document="document"></page-content>
  <production-index v-else-if="collection === 'production' && document === 'list'"></production-index>
  <production-content v-else-if="collection === 'production' && !action" :document="document"></production-content>
  <production-form v-else-if="collection === 'production' && action === 'production-write'" :document="document" :action="action"></production-form>
  <Production-mlist-form v-else-if="collection === 'production' && action === 'article-write' && document === 'machine-list'" :document= "document" :action="action"></Production-mlist-form>
  <Production-package-form v-else-if="collection === 'production' && action === 'article-write' && document === 'package'" :document= "document" :action="action"></Production-package-form>
  <error-page v-else></error-page>
</template>
<script>
import BoardIndex from './board/index'
import BoardContent from './board/content'
import BoardForm from './board/form'
import BoardArticleForm from './board/article/form'
import PageIndex from './page/index'
import PageContent from './page/content'
import ProductionIndex from './production/index'
import ProductionContent from './production/content'
import ProductionForm from './production/form'
import ProductionMlistForm from './production/mlist/form'
import ProductionPackageForm from './production/package/form'
import ErrorPage from './error'
export default {
  components: {
    BoardIndex,
    BoardContent,
    BoardForm,
    BoardArticleForm,
    PageIndex,
    PageContent,
    ProductionIndex,
    ProductionContent,
    ProductionForm,
    ProductionMlistForm,
    ProductionPackageForm,
    ErrorPage
  },
  computed: {
    collection () {
      return this.$route.params.collection
    },
    document () {
      return this.$route.params.document
    },
    action () {
      return this.$route.params.action
    }
  }
}
</script>
