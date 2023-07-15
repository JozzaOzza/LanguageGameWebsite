// _app.js
import '../global.css'
import { ChakraProvider } from '@chakra-ui/react'

const MyApp = ({ Component, pageProps }) => {
  return (
    <ChakraProvider>
      <Component {...pageProps} />
    </ChakraProvider>
  )
}
export default MyApp