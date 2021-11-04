<template>
  <quality-content v-if="collection === 'quality' && !action" :document="document"></quality-content>
  <quality-form v-else-if="collection === 'quality' && action === 'quality-write'" :document="document" :action="action"></quality-form>
  <quality-article-form v-else-if="collection === 'quality' && action === 'article-write'" :document="document" :action="action"></quality-article-form>
  <production-content v-else-if="collection === 'production' && !action" :document="document"></production-content>
  <production-form v-else-if="collection === 'production' && action === 'production-write'" :document="document" :action="action"></production-form>
  <Production-mlist-form v-else-if="collection === 'production' && action === 'article-write' && document === 'machine-list'" :document= "document" :action="action"></Production-mlist-form>
  <Production-package-form v-else-if="collection === 'production' && action === 'article-write' && document === 'package'" :document= "document" :action="action"></Production-package-form>
  <error-page v-else></error-page>
</template>
<script>
import QualityContent from './quality/content'
import QualityForm from './quality/form'
import QualityArticleForm from './quality/article/form'
import ProductionContent from './production/content'
import ProductionForm from './production/form'
import ProductionMlistForm from './production/mlist/form'
import ProductionPackageForm from './production/package/form'
import ErrorPage from './error'
export default {
  components: {
    QualityContent,
    QualityForm,
    QualityArticleForm,
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
