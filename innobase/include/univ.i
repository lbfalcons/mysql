/***************************************************************************
Version control for database, common definitions, and include files

(c) 1994 - 2000 Innobase Oy

Created 1/20/1994 Heikki Tuuri
****************************************************************************/

#ifndef univ_i
#define univ_i

#if (defined(_WIN32) || defined(_WIN64))
#define __WIN__
#include <windows.h>


#else
/* The Unix version */

/* Include two header files from MySQL to make the Unix flavor used
in compiling more Posix-compatible. We assume that 'innobase' is a
subdirectory of 'mysql'. */
#include <global.h>
#include <my_pthread.h>

#undef PACKAGE
#undef VERSION

/* Include the header file generated by GNU autoconf */
#include "../ib_config.h"

#ifdef HAVE_PREAD
#define HAVE_PWRITE
#endif

#endif

/*			DEBUG VERSION CONTROL
			===================== */
/* Make a non-inline debug version */
/*
#define UNIV_DEBUG
#define UNIV_MEM_DEBUG
#define UNIV_SYNC_DEBUG
#define UNIV_SEARCH_DEBUG

#define UNIV_IBUF_DEBUG

#define UNIV_SYNC_PERF_STAT
#define UNIV_SEARCH_PERF_STAT
*/
#define UNIV_LIGHT_MEM_DEBUG

#define YYDEBUG			1

/*
#define UNIV_SQL_DEBUG
#define UNIV_LOG_DEBUG
*/
			/* the above option prevents forcing of log to disk
			at a buffer page write: it should be tested with this
			option off; also some ibuf tests are suppressed */
/*
#define UNIV_BASIC_LOG_DEBUG
*/
			/* the above option enables basic recovery debugging:
			new allocated file pages are reset */

#if (!defined(UNIV_DEBUG) && !defined(INSIDE_HA_INNOBASE_CC))
/* Definition for inline version */

#ifdef __WIN__
#define UNIV_INLINE  	__inline
#else
/* config.h contains the right def for 'inline' for the current compiler */
#define UNIV_INLINE  extern inline

#endif

#else
/* If we want to compile a noninlined version we use the following macro
definitions: */

#define UNIV_NONINL
#define UNIV_INLINE

#endif	/* UNIV_DEBUG */

#ifdef _WIN32
#define UNIV_WORD_SIZE		4
#elif defined(_WIN64)
#define UNIV_WORD_SIZE		8
#else
/* config.h generated by GNU autoconf will define SIZEOF_INT in Posix */
#define UNIV_WORD_SIZE		SIZEOF_INT
#endif

/* The following alignment is used in memory allocations in memory heap
management to ensure correct alignment for doubles etc. */
#define UNIV_MEM_ALIGNMENT      8

/* The following alignment is used in aligning lints etc. */
#define UNIV_WORD_ALIGNMENT	UNIV_WORD_SIZE

/*
			DATABASE VERSION CONTROL
			========================
*/

/* The universal page size of the database */
#define UNIV_PAGE_SIZE          (2 * 8192) /* NOTE! Currently, this has to be a
					power of 2 */
/* The 2-logarithm of UNIV_PAGE_SIZE: */
#define UNIV_PAGE_SIZE_SHIFT	14					

/* Maximum number of parallel threads in a parallelized operation */
#define UNIV_MAX_PARALLELISM	32

/*
			UNIVERSAL TYPE DEFINITIONS
			==========================
*/

/* Note that inside MySQL 'byte' is defined as char on Linux! */
#define byte	unsigned char

/* Another basic type we use is unsigned long integer which is intended to be
equal to the word size of the machine. */

typedef unsigned long int	ulint;

typedef long int		lint;

/* The following type should be at least a 64-bit floating point number */
typedef double		utfloat;

/* The 'undefined' value for a ulint */
#define ULINT_UNDEFINED		((ulint)(-1))

/* The undefined 32-bit unsigned integer */
#define	ULINT32_UNDEFINED	0xFFFFFFFF

/* Maximum value for a ulint */
#define ULINT_MAX		((ulint)(-2))

/* This 'ibool' type is used within Innobase. Remember that different included
headers may define 'bool' differently. Do not assume that 'bool' is a ulint! */
#define ibool	ulint

#ifndef TRUE

#define TRUE    1
#define FALSE   0

#endif

/* The following number as the length of a logical field means that the field
has the SQL NULL as its value. */
#define UNIV_SQL_NULL 	ULINT_UNDEFINED

#include <stdio.h>
#include "ut0dbg.h"
#include "ut0ut.h"
#include "db0err.h"

#endif
