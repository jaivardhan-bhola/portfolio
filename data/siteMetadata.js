const siteMetadata = {
  title: 'Jaivardhan Bhola',
  author: 'Jaivardhan Bhola',
  headerTitle: 'jaivardhanbhola',
  description: 'Student',
  language: 'en-us',
  theme: 'dark', // system, dark or light
  siteUrl: 'https://jaivardhan.netlify.app',
  siteRepo: 'https://github.com/jaivardhan-bhola/portfolio',
  siteLogo: '/static/images/logo.png',
  image: '/static/images/avatar.webp',
  email: 'jaivardhan.bhola@gmail.com',  
  socialBanner: '/static/images/twitter-card.png',
  github: 'https://github.com/jaivardhan-bhola',
  twitter: 'https://twitter.com/BholaJaivardhan',
  linkedin: 'https://www.linkedin.com/in/jaivardhan-bhola-773944214/',
  AppleMusic: 'https://music.apple.com/us/profile/jaivardhanb?ls',
  medium: 'https://medium.com/@jaivardhan.bhola',
  discord: 'https://discord.com/users/1042847574417231902',
  instagram: 'https://www.instagram.com/jaivardhan_b/',
  locale: 'en-US',
  comment: {
    provider: 'giscus',
    giscusConfig: {
      repo: process.env.NEXT_PUBLIC_GISCUS_REPO || '',
      repositoryId: process.env.NEXT_PUBLIC_GISCUS_REPOSITORY_ID || '',
      category: process.env.NEXT_PUBLIC_GISCUS_CATEGORY || '',
      categoryId: process.env.NEXT_PUBLIC_GISCUS_CATEGORY_ID || '',
      mapping: 'pathname',
      reactions: '1',
      metadata: '0',
      theme: 'light',
      darkTheme: 'transparent_dark',
      themeURL: '',
    },
  },
}

module.exports = siteMetadata
